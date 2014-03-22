class ProcessingFeeStatusesController < ApplicationController
  authorize_resource
  # GET /processing_fee_statuses
  # GET /processing_fee_statuses.json
  def index
    @processing_fee_statuses = ProcessingFeeStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @processing_fee_statuses }
    end
  end

  # GET /processing_fee_statuses/1
  # GET /processing_fee_statuses/1.json
  def show
    @processing_fee_status = ProcessingFeeStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @processing_fee_status }
    end
  end

  # GET /processing_fee_statuses/new
  # GET /processing_fee_statuses/new.json
  def new
    @processing_fee_status = ProcessingFeeStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @processing_fee_status }
    end
  end

  # GET /processing_fee_statuses/1/edit
  def edit
    @processing_fee_status = ProcessingFeeStatus.find(params[:id])
  end

  # POST /processing_fee_statuses
  # POST /processing_fee_statuses.json
  def create
    @processing_fee_status = ProcessingFeeStatus.new(params[:processing_fee_status])

    respond_to do |format|
      if @processing_fee_status.save
        format.html { redirect_to processing_fee_statuses_path, notice: 'Processing fee status was successfully created.' }
        format.json { render json: @processing_fee_status, status: :created, location: @processing_fee_status }
      else
        format.html { render action: "new" }
        format.json { render json: @processing_fee_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /processing_fee_statuses/1
  # PUT /processing_fee_statuses/1.json
  def update
    @processing_fee_status = ProcessingFeeStatus.find(params[:id])

    respond_to do |format|
      if @processing_fee_status.update_attributes(params[:processing_fee_status])
        format.html { redirect_to processing_fee_statuses_path, notice: 'Processing fee status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @processing_fee_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processing_fee_statuses/1
  # DELETE /processing_fee_statuses/1.json
  def destroy
    @processing_fee_status = ProcessingFeeStatus.find(params[:id])
    @processing_fee_status.destroy

    respond_to do |format|
      format.html { redirect_to processing_fee_statuses_url }
      format.json { head :no_content }
    end
  end
end
