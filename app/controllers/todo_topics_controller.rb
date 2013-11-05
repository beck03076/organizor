class TodoTopicsController < ApplicationController
  authorize_resource
  # GET /todo_topics
  # GET /todo_topics.json
  def index
    @todo_topics = TodoTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todo_topics }
    end
  end

  # GET /todo_topics/1
  # GET /todo_topics/1.json
  def show
    @todo_topic = TodoTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo_topic }
    end
  end

  # GET /todo_topics/new
  # GET /todo_topics/new.json
  def new
    @todo_topic = TodoTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo_topic }
    end
  end

  # GET /todo_topics/1/edit
  def edit
    @todo_topic = TodoTopic.find(params[:id])
  end

  # POST /todo_topics
  # POST /todo_topics.json
  def create
    @todo_topic = TodoTopic.new(params[:todo_topic])

    respond_to do |format|
      if @todo_topic.save
        format.html { redirect_to todo_topics_path, notice: 'Todo topic was successfully created.' }
        format.json { render json: @todo_topic, status: :created, location: @todo_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @todo_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todo_topics/1
  # PUT /todo_topics/1.json
  def update
    @todo_topic = TodoTopic.find(params[:id])

    respond_to do |format|
      if @todo_topic.update_attributes(params[:todo_topic])
        format.html { redirect_to @todo_topic, notice: 'Todo topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_topics/1
  # DELETE /todo_topics/1.json
  def destroy
    @todo_topic = TodoTopic.find(params[:id])
    @todo_topic.destroy

    respond_to do |format|
      format.html { redirect_to todo_topics_url }
      format.json { head :no_content }
    end
  end
end
