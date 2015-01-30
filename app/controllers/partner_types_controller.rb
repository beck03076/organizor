class PartnerTypesController < ApplicationController
  authorize_resource
  # GET /partner_types
  # GET /partner_types.json
  def index
    @partner_types = PartnerType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partner_types }
    end
  end

  # GET /partner_types/1
  # GET /partner_types/1.json
  def show
    @partner_type = PartnerType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner_type }
      format.js
    end
  end

  # GET /partner_types/new
  # GET /partner_types/new.json
  def new
    @partner_type = PartnerType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partner_type }
    end
  end

  # GET /partner_types/1/edit
  def edit
    @partner_type = PartnerType.find(params[:id])
  end

  # POST /partner_types
  # POST /partner_types.json
  def create
    @partner_type = PartnerType.new(params[:partner_type])

    respond_to do |format|
      if @partner_type.save
        format.html { redirect_to partner_types_path, notice: 'Partner type was successfully created.' }
        format.json { render json: @partner_type, status: :created, location: @partner_type }
      else
        format.html { render action: "new" }
        format.json { render json: @partner_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partner_types/1
  # PUT /partner_types/1.json
  def update
    @partner_type = PartnerType.find(params[:id])

    respond_to do |format|
      if @partner_type.update_attributes(params[:partner_type])
        format.html { redirect_to partner_types_path, notice: 'Partner type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partner_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partner_types/1
  # DELETE /partner_types/1.json
  def destroy
    @partner_type = PartnerType.find(params[:id])
    @partner_type.destroy

    respond_to do |format|
      format.html { redirect_to partner_types_url }
      format.json { head :no_content }
    end
  end
end
