class ProgrammeTypesController < ApplicationController
  # GET /programme_types
  # GET /programme_types.json
  def index
    @programme_types = ProgrammeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programme_types }
    end
  end

  # GET /programme_types/1
  # GET /programme_types/1.json
  def show
    @programme_type = ProgrammeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @programme_type }
    end
  end

  # GET /programme_types/new
  # GET /programme_types/new.json
  def new
    @programme_type = ProgrammeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @programme_type }
    end
  end

  # GET /programme_types/1/edit
  def edit
    @programme_type = ProgrammeType.find(params[:id])
  end

  # POST /programme_types
  # POST /programme_types.json
  def create
    @programme_type = ProgrammeType.new(params[:programme_type])

    respond_to do |format|
      if @programme_type.save
        format.html { redirect_to @programme_type, notice: 'Programme type was successfully created.' }
        format.json { render json: @programme_type, status: :created, location: @programme_type }
      else
        format.html { render action: "new" }
        format.json { render json: @programme_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programme_types/1
  # PUT /programme_types/1.json
  def update
    @programme_type = ProgrammeType.find(params[:id])

    respond_to do |format|
      if @programme_type.update_attributes(params[:programme_type])
        format.html { redirect_to @programme_type, notice: 'Programme type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @programme_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programme_types/1
  # DELETE /programme_types/1.json
  def destroy
    @programme_type = ProgrammeType.find(params[:id])
    @programme_type.destroy

    respond_to do |format|
      format.html { redirect_to programme_types_url }
      format.json { head :no_content }
    end
  end
end
