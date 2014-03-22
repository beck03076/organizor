class ProcessingFeeTypesController < ApplicationController
  authorize_resource
  # GET /processing_fee_types
  # GET /processing_fee_types.json
  def index
    @processing_fee_types = ProcessingFeeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @processing_fee_types }
    end
  end

  # GET /processing_fee_types/1
  # GET /processing_fee_types/1.json
  def show
    @processing_fee_type = ProcessingFeeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @processing_fee_type }
    end
  end

  # GET /processing_fee_types/new
  # GET /processing_fee_types/new.json
  def new
    @processing_fee_type = ProcessingFeeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @processing_fee_type }
    end
  end

  # GET /processing_fee_types/1/edit
  def edit
    @processing_fee_type = ProcessingFeeType.find(params[:id])
  end

  # POST /processing_fee_types
  # POST /processing_fee_types.json
  def create
    @processing_fee_type = ProcessingFeeType.new(params[:processing_fee_type])

    respond_to do |format|
      if @processing_fee_type.save
        format.html { redirect_to processing_fee_types_path, notice: 'Processing fee type was successfully created.' }
        format.json { render json: @processing_fee_type, status: :created, location: @processing_fee_type }
      else
        format.html { render action: "new" }
        format.json { render json: @processing_fee_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /processing_fee_types/1
  # PUT /processing_fee_types/1.json
  def update
    @processing_fee_type = ProcessingFeeType.find(params[:id])

    respond_to do |format|
      if @processing_fee_type.update_attributes(params[:processing_fee_type])
        format.html { redirect_to processing_fee_types_path, notice: 'Processing fee type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @processing_fee_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processing_fee_types/1
  # DELETE /processing_fee_types/1.json
  def destroy
    @processing_fee_type = ProcessingFeeType.find(params[:id])
    @processing_fee_type.destroy

    respond_to do |format|
      format.html { redirect_to processing_fee_types_url }
      format.json { head :no_content }
    end
  end
end
