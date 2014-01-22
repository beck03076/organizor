class CommissionStatusesController < ApplicationController
  authorize_resource
  # GET /commission_statuses
  # GET /commission_statuses.json
  def index
    @commission_statuses = CommissionStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commission_statuses }
    end
  end

  # GET /commission_statuses/1
  # GET /commission_statuses/1.json
  def show
    @commission_status = CommissionStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commission_status }
    end
  end

  # GET /commission_statuses/new
  # GET /commission_statuses/new.json
  def new
    @commission_status = CommissionStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commission_status }
    end
  end

  # GET /commission_statuses/1/edit
  def edit
    @commission_status = CommissionStatus.find(params[:id])
  end

  # POST /commission_statuses
  # POST /commission_statuses.json
  def create
    @commission_status = CommissionStatus.new(params[:commission_status])

    respond_to do |format|
      if @commission_status.save
        format.html { redirect_to commission_statuses_path, notice: 'Commission status was successfully created.' }
        format.json { render json: @commission_status, status: :created, location: @commission_status }
      else
        format.html { render action: "new" }
        format.json { render json: @commission_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commission_statuses/1
  # PUT /commission_statuses/1.json
  def update
    @commission_status = CommissionStatus.find(params[:id])

    respond_to do |format|
      if @commission_status.update_attributes(params[:commission_status])
        format.html { redirect_to commission_statuses_path, notice: 'Commission status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commission_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commission_statuses/1
  # DELETE /commission_statuses/1.json
  def destroy
    @commission_status = CommissionStatus.find(params[:id])
    @commission_status.destroy

    respond_to do |format|
      format.html { redirect_to commission_statuses_url }
      format.json { head :no_content }
    end
  end
end
