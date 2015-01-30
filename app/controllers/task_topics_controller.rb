class TaskTopicsController < ApplicationController
  authorize_resource
  # GET /task_topics
  # GET /task_topics.json
  def index
    @task_topics = TaskTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_topics }
    end
  end

  # GET /task_topics/1
  # GET /task_topics/1.json
  def show
    @task_topic = TaskTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_topic }
    end
  end

  # GET /task_topics/new
  # GET /task_topics/new.json
  def new
    @task_topic = TaskTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_topic }
    end
  end

  # GET /task_topics/1/edit
  def edit
    @task_topic = TaskTopic.find(params[:id])
  end

  # POST /task_topics
  # POST /task_topics.json
  def create
    @task_topic = TaskTopic.new(params[:task_topic])

    respond_to do |format|
      if @task_topic.save
        format.html { redirect_to task_topics_path, notice: 'Task topic was successfully created.' }
        format.json { render json: @task_topic, status: :created, location: @task_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @task_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_topics/1
  # PUT /task_topics/1.json
  def update
    @task_topic = TaskTopic.find(params[:id])

    respond_to do |format|
      if @task_topic.update_attributes(params[:task_topic])
        format.html { redirect_to task_topics_path, notice: 'Task topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_topics/1
  # DELETE /task_topics/1.json
  def destroy
    @task_topic = TaskTopic.find(params[:id])
    @task_topic.destroy

    respond_to do |format|
      format.html { redirect_to task_topics_url }
      format.json { head :no_content }
    end
  end
end
