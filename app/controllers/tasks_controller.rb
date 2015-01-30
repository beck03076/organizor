class TasksController < ApplicationController
authorize_resource
skip_authorize_resource :only => :show_hover

  def show_hover 
    @task = Task.find(params[:id])
    render partial: "tasks/show_hover" 
  end
  # GET /tasks
  # GET /tasks.json
  def index
    temp = current_user.tasks.includes(:topic,:_ass_by).order('created_at DESC')
    
    if !params[:filter].nil?
      hsh = {}
      [:done,:assigned_by,:duedate,:topic_id].each do |i|
        if !params[i].blank?
          hsh[i] = params[i]
        end
      end
      if params[:period].present?
        @tasks = temp.where(hsh).send(params[:period])
      else
        @tasks = temp.where(hsh)
      end
    else    
      @tasks = temp.order('done asc')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }      
      format.js
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
  
    if params[:task][:model]
        m = params[:task][:model]
        m_id = (m + "_id").to_sym
        params[:task].delete(:model)
    end
    
    # if ref_no is passed, find the registration and assign
    if params[:task][:ref_no]
      temp = params[:task][:ref_no]
      if !temp.blank?
        params[:task][:registration_id] = Registration.find_by_ref_no(temp).id
      end
      params[:task].delete(:ref_no)
    end
    
    # assigning defaults in not given if nothing is given
    if params[:task][:topic_id].blank?
      params[:task][:topic_id] = TaskTopic.find_by_name("default").id
    end
    if params[:task][:assigned_to].blank?
      params[:task][:assigned_to] = current_user.id
    end
    
    @task = Task.new(params[:task].except("sub_id","sub_class","task"))

    respond_to do |format|
      if @task.save
        
        format.html { 
        # this is the part where the task is going to be saved to google
        if @task.api
          session[:task_id] = @task.id
          session[:destination] = '/tasks/google_create'
          redirect_to "/auth/google_oauth2"
          return
        end
        
        if !m.blank? && !params[:task][m_id].blank?
        
          tl(m.capitalize,params[:task][m_id],"Assigned to " + @task._ato.name,
         @task.topic.name + ' task, due on ' + params[:task][:duedate],'task',params[:task][:assigned_to])
         
          redirect_to "/#{m.pluralize.downcase}/" + params[:task][m_id].to_s 
        else
        
          tl("Task",@task.id,"Assigned to " + @task._ato.name,
         @task.topic.name + ' task, due on ' + params[:task][:duedate],'task',params[:task][:assigned_to])
         
          redirect_to tasks_path
        end
        }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
        
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
  
  def google_create
    # finding and setting the task from session task_id
    @task = Task.find(session[:task_id])
    # preparing a json task accepatable by google
    task = self.create_google_task(@task)
    
    self.set_api
    self.check_and_sync_tasklists
        
    @result = @client.execute(
                     :api_method => @service.tasks.insert,
                     :parameters => {'tasklist' => (@task.topic.api_id || '@default')},
                     :body => JSON.dump(task),
                     :headers => {'Content-Type' => 'application/json'})
    
    #updating the created do with the id of the google api
    @task.update_attribute(:api_id, @result.data.id)
    redirect_to '/tasks'
  end  
  
  def start_sync
    @tasks = current_user.tasks.where(api: false)
    session[:destination] = '/tasks/google_sync'
    redirect_to "/auth/google_oauth2"
    return
  end
  
  
  def google_sync
  
    self.set_api  
    self.check_and_sync_tasklists
    self.check_and_sync_tasks
    
    current_user.tasks.update_all(api: true)
    flash[:notice] = "Tasks Sync successful, check your google tasks!"
    redirect_to '/tasks'
    
  end
  
  def check_and_sync_tasks

    topics = current_user.tasks.includes(:topic).map{|i| i.topic}.uniq
    task_json_arr = []
    
    topics.each do |parent_topic|
        self.set_google_tasks(parent_topic)
        task_ids = @google_tasks.map &:id
        tasks = parent_topic.user_tasks(current_user.id)
        
        tasks.map do |task|

          if !task_ids.include?(task.api_id) or task.api_id.nil?
          
             p "###==INSERT NEW TASK - #{task.title} ==###"
             
               task_json = self.create_google_task(task)
               
               result = {:api_method => @service.tasks.insert,
                             :parameters => {'tasklist' => (task.topic.api_id || '@default'),
                             "task_id" => task.id},
                             :body => JSON.dump(task_json),
                             :headers => {'Content-Type' => 'application/json'},
                            }
                            
               task_json_arr << result
          else
          
             
             
               @google_tasks.map {|i| if i.id == task.api_id; @g_task = i ; end; }

               if task.updated_at.to_time > @g_task["updated"].to_time
               
                  p "###==UPDATE OLD TASK - #{task.title}==###"
                   
                   task_json = self.create_google_task(task,task.api_id)
                  
                   result = {:api_method => @service.tasks.update,
                             :parameters => {'tasklist' => (task.topic.api_id || '@default'),
                                             "task_id" => task.id,
                                             "task" => task.api_id},
                             :body => JSON.dump(task_json),
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
          Task.find(result.request.parameters["task_id"].to_i).update_attribute(:api_id, result.data.id) 
        end
        # add all the json items in the array(tasks) as one batch request in 'batch'
        task_json_arr.map {|i| batch.add(i)}
        @client.execute(batch)
    end
  
  end
=begin
  def set_result(json,method,task)
    {:api_method => @service.tasks.send(method),
     :parameters => {'tasklist' => (task.topic.api_id || '@default'),
     "task_id" => task.id,
     "task" => ""},
     :body => JSON.dump(json),
     :headers => {'Content-Type' => 'application/json'},
    }
  end
=end
  def check_and_sync_tasklists
    @tasktopics = TaskTopic.all
    tasklist_json_arr = []
  
    self.set_google_tasklists
    tasklist_ids = @google_tasklists.map &:id
    
    @tasktopics.map do |topic|
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
          TaskTopic.find(result.request.parameters["topic_id"].to_i).update_attribute(:api_id, result.data.id)
        end
        # add all the json items in the array(tasks) as one batch request in 'batch'
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
