class EnquiryStatusesController < ApplicationController
  authorize_resource
  # GET /enquiry_statuses
  # GET /enquiry_statuses.json
  def index
    @enquiry_statuses = EnquiryStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @enquiry_statuses }
    end
  end

  # GET /enquiry_statuses/1
  # GET /enquiry_statuses/1.json
  def show
    @enquiry_status = EnquiryStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @enquiry_status }
    end
  end

  # GET /enquiry_statuses/new
  # GET /enquiry_statuses/new.json
  def new
    @enquiry_status = EnquiryStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @enquiry_status }
    end
  end

  # GET /enquiry_statuses/1/edit
  def edit
    @enquiry_status = EnquiryStatus.find(params[:id])
  end

  # POST /enquiry_statuses
  # POST /enquiry_statuses.json
  def create
    @enquiry_status = EnquiryStatus.new(params[:enquiry_status])

    respond_to do |format|
      if @enquiry_status.save
        format.html { redirect_to enquiry_statuses_path, notice: 'Enquiry status was successfully created.' }
        format.json { render json: @enquiry_status, status: :created, location: @enquiry_status }
      else
        format.html { render action: "new" }
        format.json { render json: @enquiry_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /enquiry_statuses/1
  # PUT /enquiry_statuses/1.json
  def update
    @enquiry_status = EnquiryStatus.find(params[:id])

    respond_to do |format|
      if @enquiry_status.update_attributes(params[:enquiry_status])
        format.html { redirect_to @enquiry_status, notice: 'Enquiry status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @enquiry_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enquiry_statuses/1
  # DELETE /enquiry_statuses/1.json
  def destroy
    @enquiry_status = EnquiryStatus.find(params[:id])
    @enquiry_status.destroy

    respond_to do |format|
      format.html { redirect_to enquiry_statuses_url }
      format.json { head :no_content }
    end
  end
end
