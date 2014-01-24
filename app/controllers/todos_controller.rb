class TodosController < ApplicationController
authorize_resource
skip_authorize_resource :only => :show_hover

  def show_hover 
    @todo = Todo.find(params[:id])
    render partial: "todos/show_hover" 
  end
  # GET /todos
  # GET /todos.json
  def index
    request.params[:y] = 5
    p "********"
    p request.params
    
    temp = current_user.todos.includes(:topic,:_ass_by)
    
    if !params[:filter].nil?
      hsh = {}
      [:done,:assigned_by,:duedate,:topic_id].each do |i|
        if !params[i].blank?
          hsh[i] = params[i]
        end
      end
      if params[:period].present?
        @todos = temp.where(hsh).send(params[:period])
      else
        @todos = temp.where(hsh)
      end
    else    
      @todos = temp.order('done asc')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }      
      format.js
    end
  end
  
  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
  
    if params[:todo][:model]
        m = params[:todo][:model]
        m_id = (m + "_id").to_sym
        params[:todo].delete(:model)
    end
    
    # if ref_no is passed, find the registration and assign
    if params[:todo][:ref_no]
      temp = params[:todo][:ref_no]
      if !temp.blank?
        params[:todo][:registration_id] = Registration.find_by_ref_no(temp).id
      end
      params[:todo].delete(:ref_no)
    end
    
    # assigning defaults in not given if nothing is given
    if params[:todo][:topic_id].blank?
      params[:todo][:topic_id] = TodoTopic.find_by_name("default").id
    end
    if params[:todo][:assigned_to].blank?
      params[:todo][:assigned_to] = current_user.id
    end
    
    @todo = Todo.new(params[:todo].except("sub_id","sub_class","todo"))

    respond_to do |format|
      if @todo.save
        
        format.html { 
        # this is the part where the todo is going to be saved to google
        if @todo.api
          session[:todo_id] = @todo.id
          session[:destination] = '/todos/google_create'
          redirect_to "/auth/google_oauth2"
          return
        end
        
        if !m.blank? && !params[:todo][m_id].blank?
        
          tl(m.capitalize,params[:todo][m_id],"Assigned to " + @todo._ato.name,
         @todo.topic.name + ' task, due on ' + params[:todo][:duedate],'todo',params[:todo][:assigned_to])
         
          redirect_to "/#{m.pluralize.downcase}/" + params[:todo][m_id].to_s 
        else
        
          tl("Todo",@todo.id,"Assigned to " + @todo._ato.name,
         @todo.topic.name + ' task, due on ' + params[:todo][:duedate],'todo',params[:todo][:assigned_to])
         
          redirect_to todos_path
        end
        }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])
    
    if params[:todo][:done]
    
             if params[:todo][:done].to_s == "true" 
              res = "done"
              params[:todo][:done_at] = Time.now
             else 
              res = "undone"
              params[:todo][:done_at] = nil
             end
      tl("Todo",@todo.id,'This todo has been marked ' + res,
          (@todo.topic.name rescue nil),'todo',@todo.assigned_by)
    else
      tl("Todo",@todo.id,'This todo has been updated',
          (@todo.topic.name rescue nil),'todo',@todo.assigned_to)
    end
    
    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end
  
  def google_create
    # finding and setting the todo from session todo_id
    @todo = Todo.find(session[:todo_id])
    # preparing a json todo accepatable by google
    todo = self.create_google_task(@todo)
    
    self.set_api
    self.check_and_sync_tasklists
        
    @result = @client.execute(
                     :api_method => @service.tasks.insert,
                     :parameters => {'tasklist' => (@todo.topic.api_id || '@default')},
                     :body => JSON.dump(todo),
                     :headers => {'Content-Type' => 'application/json'})
    
    #updating the created do with the id of the google api
    @todo.update_attribute(:api_id, @result.data.id)
    redirect_to '/todos'
  end  
  
  def start_sync
    @todos = current_user.todos.where(api: false)
    session[:destination] = '/todos/google_sync'
    redirect_to "/auth/google_oauth2"
    return
  end
  
  
  def google_sync
  
    self.set_api  
    self.check_and_sync_tasklists
    self.check_and_sync_tasks
    
    current_user.todos.update_all(api: true)
    flash[:notice] = "Todos Sync successful, check your google tasks!"
    redirect_to '/todos'
    
  end
  
  def check_and_sync_tasks

    topics = current_user.todos.includes(:topic).map{|i| i.topic}.uniq
    task_json_arr = []
    
    topics.each do |parent_topic|
        self.set_google_tasks(parent_topic)
        task_ids = @google_tasks.map &:id
        todos = parent_topic.user_todos(current_user.id)
        
        todos.map do |todo|

          if !task_ids.include?(todo.api_id) or todo.api_id.nil?
          
             p "###==INSERT NEW TASK - #{todo.title} ==###"
             
               todo_json = self.create_google_task(todo)
               
               result = {:api_method => @service.tasks.insert,
                             :parameters => {'tasklist' => (todo.topic.api_id || '@default'),
                             "todo_id" => todo.id},
                             :body => JSON.dump(todo_json),
                             :headers => {'Content-Type' => 'application/json'},
                            }
                            
               task_json_arr << result
          else
          
             
             
               @google_tasks.map {|i| if i.id == todo.api_id; @g_task = i ; end; }

               if todo.updated_at.to_time > @g_task["updated"].to_time
               
                  p "###==UPDATE OLD TASK - #{todo.title}==###"
                   
                   todo_json = self.create_google_task(todo,todo.api_id)
                  
                   result = {:api_method => @service.tasks.update,
                             :parameters => {'tasklist' => (todo.topic.api_id || '@default'),
                                             "todo_id" => todo.id,
                                             "task" => todo.api_id},
                             :body => JSON.dump(todo_json),
                             :headers => {'Content-Type' => 'application/json'},
                            }
                   task_json_arr << result
               end
          end
        end

    end

    if !task_json_arr.blank?
        # creating a google batch object
        batch = Google::APIClient::BatchRequest.new do |result|
          Todo.find(result.request.parameters["todo_id"].to_i).update_attribute(:api_id, result.data.id) 
        end
        # add all the json items in the array(todos) as one batch request in 'batch'
        task_json_arr.map {|i| batch.add(i)}
        @client.execute(batch)
    end
  
  end
=begin
  def set_result(json,method,todo)
    {:api_method => @service.tasks.send(method),
     :parameters => {'tasklist' => (todo.topic.api_id || '@default'),
     "todo_id" => todo.id,
     "task" => ""},
     :body => JSON.dump(json),
     :headers => {'Content-Type' => 'application/json'},
    }
  end
=end
  def check_and_sync_tasklists
    @todotopics = TodoTopic.all
    tasklist_json_arr = []
  
    self.set_google_tasklists
    tasklist_ids = @google_tasklists.map &:id
    
    @todotopics.map do |topic|
      if !tasklist_ids.include?(topic.api_id)
        
        p "&&&==INSERT NEW TASKLIST - #{topic.name}==&&&"
        
        tasklist = {
                      "kind" => "tasks#taskList",
                      "title" => topic.name
                      }
                      
          result = {
                     :api_method => @service.tasklists.insert,
                     :parameters => {"topic_id" => topic.id},
                     :body => JSON.dump(tasklist),
                     :headers => {'Content-Type' => 'application/json'}
                   }
                   
           tasklist_json_arr << result
      end
    end

        
    if !tasklist_json_arr.blank?
        # creating a google batch object
        batch = Google::APIClient::BatchRequest.new do |result|
          TodoTopic.find(result.request.parameters["topic_id"].to_i).update_attribute(:api_id, result.data.id)
        end
        # add all the json items in the array(todos) as one batch request in 'batch'
        tasklist_json_arr.map {|i| batch.add(i)}
        @client.execute(batch)
    end
    
  end
  
  def set_google_tasks(topic)
  
   result = @client.execute(
          :api_method => @service.tasks.list,
          :parameters => {'tasklist' => (topic.api_id rescue '@default') },
          :headers => {'Content-Type' => 'application/json'})
   @google_tasks = result.data.items

  end  
  
  def set_google_tasklists
  
   result = @client.execute(
          :api_method => @service.tasklists.list,
          :headers => {'Content-Type' => 'application/json'})
   @google_tasklists = result.data.items
  
  end
  
  def create_google_task(obj,api_id = nil)

      out = {
              "kind" => "tasks#task",
              "title" => (obj.title rescue "Untitled"),
              "updated" => rfc(obj.uptd),
              "notes" => (obj.desc rescue "No description"),
              "status" => obj.done ? "completed" : "needsAction",
              "due" => rfc(obj.due),
              "completed" => rfc(obj.comp),
              "deleted" => false,
              "hidden" => false
            }
      if api_id.nil? 
        out
      else
        out["id"] = api_id
        out
      end
  end
  
  def rfc(t)
    if !t.nil?
     DateTime.parse(t).strftime('%FT%T') + ".000Z"
    else
     nil
    end
  end
  
  def set_api
  # setting the authentication token from session, set in application controller determine_redirect
    token = session[:token]
    @client = Google::APIClient.new
    @client.authorization.access_token = token
    @service = @client.discovered_api('tasks')
  end
  
end
