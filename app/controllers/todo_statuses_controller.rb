class TodoStatusesController < ApplicationController
  authorize_resource
  # GET /todo_statuses
  # GET /todo_statuses.json
  def index
    @todo_statuses = TodoStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todo_statuses }
    end
  end

  # GET /todo_statuses/1
  # GET /todo_statuses/1.json
  def show
    @todo_status = TodoStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo_status }
    end
  end

  # GET /todo_statuses/new
  # GET /todo_statuses/new.json
  def new
    @todo_status = TodoStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo_status }
    end
  end

  # GET /todo_statuses/1/edit
  def edit
    @todo_status = TodoStatus.find(params[:id])
  end

  # POST /todo_statuses
  # POST /todo_statuses.json
  def create
    @todo_status = TodoStatus.new(params[:todo_status])

    respond_to do |format|
      if @todo_status.save
        format.html { redirect_to todo_statuses_path, notice: 'Todo status was successfully created.' }
        format.json { render json: @todo_status, status: :created, location: @todo_status }
      else
        format.html { render action: "new" }
        format.json { render json: @todo_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todo_statuses/1
  # PUT /todo_statuses/1.json
  def update
    @todo_status = TodoStatus.find(params[:id])

    respond_to do |format|
      if @todo_status.update_attributes(params[:todo_status])
        format.html { redirect_to @todo_status, notice: 'Todo status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_statuses/1
  # DELETE /todo_statuses/1.json
  def destroy
    @todo_status = TodoStatus.find(params[:id])
    @todo_status.destroy

    respond_to do |format|
      format.html { redirect_to todo_statuses_url }
      format.json { head :no_content }
    end
  end
end
