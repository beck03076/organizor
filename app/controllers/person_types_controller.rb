class PersonTypesController < ApplicationController
  authorize_resource
  # GET /person_types
  # GET /person_types.json
  def index
    @person_types = PersonType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @person_types }
    end
  end

  # GET /person_types/1
  # GET /person_types/1.json
  def show
    @person_type = PersonType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person_type }
    end
  end

  # GET /person_types/new
  # GET /person_types/new.json
  def new
    @person_type = PersonType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person_type }
    end
  end

  # GET /person_types/1/edit
  def edit
    @person_type = PersonType.find(params[:id])
  end

  # POST /person_types
  # POST /person_types.json
  def create
    @person_type = PersonType.new(params[:person_type])

    respond_to do |format|
      if @person_type.save
        format.html { redirect_to person_types_path, notice: 'Person type was successfully created.' }
        format.json { render json: @person_type, status: :created, location: @person_type }
      else
        format.html { render action: "new" }
        format.json { render json: @person_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /person_types/1
  # PUT /person_types/1.json
  def update
    @person_type = PersonType.find(params[:id])

    respond_to do |format|
      if @person_type.update_attributes(params[:person_type])
        format.html { redirect_to person_types_path, notice: 'Person type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_types/1
  # DELETE /person_types/1.json
  def destroy
    @person_type = PersonType.find(params[:id])
    @person_type.destroy

    respond_to do |format|
      format.html { redirect_to person_types_url }
      format.json { head :no_content }
    end
  end
end
