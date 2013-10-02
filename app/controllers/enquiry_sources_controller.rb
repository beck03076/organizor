class EnquirySourcesController < ApplicationController
  # GET /enquiry_sources
  # GET /enquiry_sources.json
  def index
    @enquiry_sources = EnquirySource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @enquiry_sources }
    end
  end

  # GET /enquiry_sources/1
  # GET /enquiry_sources/1.json
  def show
    @enquiry_source = EnquirySource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @enquiry_source }
    end
  end

  # GET /enquiry_sources/new
  # GET /enquiry_sources/new.json
  def new
    @enquiry_source = EnquirySource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @enquiry_source }
    end
  end

  # GET /enquiry_sources/1/edit
  def edit
    @enquiry_source = EnquirySource.find(params[:id])
  end

  # POST /enquiry_sources
  # POST /enquiry_sources.json
  def create
    @enquiry_source = EnquirySource.new(params[:enquiry_source])

    respond_to do |format|
      if @enquiry_source.save
        format.html { redirect_to @enquiry_source, notice: 'Enquiry source was successfully created.' }
        format.json { render json: @enquiry_source, status: :created, location: @enquiry_source }
      else
        format.html { render action: "new" }
        format.json { render json: @enquiry_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /enquiry_sources/1
  # PUT /enquiry_sources/1.json
  def update
    @enquiry_source = EnquirySource.find(params[:id])

    respond_to do |format|
      if @enquiry_source.update_attributes(params[:enquiry_source])
        format.html { redirect_to @enquiry_source, notice: 'Enquiry source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @enquiry_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enquiry_sources/1
  # DELETE /enquiry_sources/1.json
  def destroy
    @enquiry_source = EnquirySource.find(params[:id])
    @enquiry_source.destroy

    respond_to do |format|
      format.html { redirect_to enquiry_sources_url }
      format.json { head :no_content }
    end
  end
end
