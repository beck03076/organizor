class InstitutionTypesController < ApplicationController
  authorize_resource
  # GET /institution_types
  # GET /institution_types.json
  def index
    @institution_types = InstitutionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @institution_types }
    end
  end

  # GET /institution_types/1
  # GET /institution_types/1.json
  def show
    @institution_type = InstitutionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @institution_type }
      format.js
    end
  end

  # GET /institution_types/new
  # GET /institution_types/new.json
  def new
    @institution_type = InstitutionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @institution_type }
    end
  end

  # GET /institution_types/1/edit
  def edit
    @institution_type = InstitutionType.find(params[:id])
  end

  # POST /institution_types
  # POST /institution_types.json
  def create
    @institution_type = InstitutionType.new(params[:institution_type])

    respond_to do |format|
      if @institution_type.save
        format.html { redirect_to institution_types_path, notice: 'Institution type was successfully created.' }
        format.json { render json: @institution_type, status: :created, location: @institution_type }
      else
        format.html { render action: "new" }
        format.json { render json: @institution_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /institution_types/1
  # PUT /institution_types/1.json
  def update
    @institution_type = InstitutionType.find(params[:id])

    respond_to do |format|
      if @institution_type.update_attributes(params[:institution_type])
        format.html { redirect_to institution_types_path, notice: 'Institution type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @institution_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /institution_types/1
  # DELETE /institution_types/1.json
  def destroy
    @institution_type = InstitutionType.find(params[:id])
    @institution_type.destroy

    respond_to do |format|
      format.html { redirect_to institution_types_url }
      format.json { head :no_content }
    end
  end
end
