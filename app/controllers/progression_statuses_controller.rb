class ProgressionStatusesController < ApplicationController
  authorize_resource
  # GET /progression_statuses
  # GET /progression_statuses.json
  def index
    @progression_statuses = ProgressionStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @progression_statuses }
    end
  end

  # GET /progression_statuses/1
  # GET /progression_statuses/1.json
  def show
    @progression_status = ProgressionStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @progression_status }
    end
  end

  # GET /progression_statuses/new
  # GET /progression_statuses/new.json
  def new
    @progression_status = ProgressionStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @progression_status }
    end
  end

  # GET /progression_statuses/1/edit
  def edit
    @progression_status = ProgressionStatus.find(params[:id])
  end

  # POST /progression_statuses
  # POST /progression_statuses.json
  def create
    @progression_status = ProgressionStatus.new(params[:progression_status])

    respond_to do |format|
      if @progression_status.save
        format.html { redirect_to progression_statuses_path, notice: 'Progression status was successfully created.' }
        format.json { render json: @progression_status, status: :created, location: @progression_status }
      else
        format.html { render action: "new" }
        format.json { render json: @progression_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /progression_statuses/1
  # PUT /progression_statuses/1.json
  def update
    @progression_status = ProgressionStatus.find(params[:id])

    respond_to do |format|
      if @progression_status.update_attributes(params[:progression_status])
        format.html { redirect_to progression_statuses_path, notice: 'Progression status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @progression_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progression_statuses/1
  # DELETE /progression_statuses/1.json
  def destroy
    @progression_status = ProgressionStatus.find(params[:id])
    @progression_status.destroy

    respond_to do |format|
      format.html { redirect_to progression_statuses_url }
      format.json { head :no_content }
    end
  end
end
