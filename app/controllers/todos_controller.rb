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
    set_url_params
    if @ass_by.to_i == current_user.id
     @todos = Todo.includes(:status,:topic).where(assigned_by: @ass_by).order('done asc')
    elsif @ass_to.to_i == current_user.id
     @todos = Todo.includes(:status,:topic).where(assigned_to: @ass_to).order('done asc')
    elsif current_user.adm? && @ass_to
     @todos = Todo.includes(:status,:topic).where(assigned_to: @ass_to).order('done asc')
    elsif current_user.adm? && @ass_by
     @todos = Todo.includes(:status,:topic).where(assigned_by: @ass_by).order('done asc')
    else
      @todos = current_user.todos.includes(:status,:topic).order('done asc')
    end
    
    @todo = Todo.new
    # supressing the listing of todos associated with enqs/regs
    @list = 0

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end
  
  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
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
    @todo = Todo.new(params[:todo].except("sub_id","sub_class","todo"))
    
    if (params[:todo][:todo].to_s == "from_action")
      topic = TodoTopic.find(params[:todo][:topic_id]).name
      ass_to = User.find(params[:todo][:assigned_to]).first_name
      
       tl(params[:todo][:sub_class],params[:todo][:sub_id],"Assigned to " + ass_to,
         topic + ' task, due on ' + params[:todo][:duedate],'todo',params[:todo][:assigned_to])
                       
    end

    respond_to do |format|
      if @todo.save
        format.html { 
        if params[:todo][:sub_class]
          redirect_to "/#{params[:todo][:sub_class].pluralize.downcase}/" + params[:todo][:sub_id].to_s 
        else
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
end
