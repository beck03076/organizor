class ApplicationStatusesController < ApplicationController
  authorize_resource
  # GET /application_statuses
  # GET /application_statuses.json
  def index
    @application_statuses = ApplicationStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @application_statuses }
    end
  end

  # GET /application_statuses/1
  # GET /application_statuses/1.json
  def show
    @application_status = ApplicationStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application_status }
      format.js
    end
  end

  # GET /application_statuses/new
  # GET /application_statuses/new.json
  def new
    @application_status = ApplicationStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application_status }
    end
  end

  # GET /application_statuses/1/edit
  def edit
    @application_status = ApplicationStatus.find(params[:id])
  end

  # POST /application_statuses
  # POST /application_statuses.json
  def create
    @application_status = ApplicationStatus.new(params[:application_status])

    respond_to do |format|
      if @application_status.save
        format.html { redirect_to application_statuses_path, notice: 'Application status was successfully created.' }
        format.json { render json: @application_status, status: :created, location: @application_status }
      else
        format.html { render action: "new" }
        format.json { render json: @application_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /application_statuses/1
  # PUT /application_statuses/1.json
  def update
    @application_status = ApplicationStatus.find(params[:id])

    respond_to do |format|
      if @application_status.update_attributes(params[:application_status])
        format.html { redirect_to application_statuses_path, notice: 'Application status was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @application_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_statuses/1
  # DELETE /application_statuses/1.json
  def destroy
    @application_status = ApplicationStatus.find(params[:id])
    @application_status.destroy

    respond_to do |format|
      format.html { redirect_to application_statuses_url }
      format.json { head :no_content }
    end
  end
end
