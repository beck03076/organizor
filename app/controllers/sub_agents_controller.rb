class SubAgentsController < ApplicationController
  authorize_resource
  # GET /sub_agents
  # GET /sub_agents.json
  def index
    @sub_agents = SubAgent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_agents }
    end
  end

  # GET /sub_agents/1
  # GET /sub_agents/1.json
  def show
    @sub_agent = SubAgent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_agent }
    end
  end

  # GET /sub_agents/new
  # GET /sub_agents/new.json
  def new
    @sub_agent = SubAgent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_agent }
    end
  end

  # GET /sub_agents/1/edit
  def edit
    @sub_agent = SubAgent.find(params[:id])
  end

  # POST /sub_agents
  # POST /sub_agents.json
  def create
    @sub_agent = SubAgent.new(params[:sub_agent])

    respond_to do |format|
      if @sub_agent.save
        format.html { redirect_to sub_agents_path, notice: 'Sub agent was successfully created.' }
        format.json { render json: @sub_agent, status: :created, location: @sub_agent }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_agents/1
  # PUT /sub_agents/1.json
  def update
    @sub_agent = SubAgent.find(params[:id])

    respond_to do |format|
      if @sub_agent.update_attributes(params[:sub_agent])
        format.html { redirect_to @sub_agent, notice: 'Sub agent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_agents/1
  # DELETE /sub_agents/1.json
  def destroy
    @sub_agent = SubAgent.find(params[:id])
    @sub_agent.destroy

    respond_to do |format|
      format.html { redirect_to sub_agents_url }
      format.json { head :no_content }
    end
  end
end
