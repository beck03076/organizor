class QualificationNamesController < ApplicationController
  authorize_resource
  # GET /qualifications
  # GET /qualifications.json
  def index
    @qualification_names = QualificationName.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qualification_names }
    end
  end

  # GET /qualifications/1
  # GET /qualifications/1.json
  def show
    @qualification_name = QualificationName.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qualification_name }
    end
  end

  # GET /qualifications/new
  # GET /qualifications/new.json
  def new
    @qualification_name = QualificationName.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qualification_name }
    end
  end

  # GET /qualifications/1/edit
  def edit
    @qualification_name = QualificationName.find(params[:id])
  end

  # POST /qualifications
  # POST /qualifications.json
  def create
    @qualification_name = QualificationName.new(params[:qualification_name])

    respond_to do |format|
      if @qualification_name.save
        format.html { redirect_to qualification_names_path, notice: 'QualificationName was successfully created.' }
        format.json { render json: @qualification_name, status: :created, location: @qualification_name }
      else
        format.html { render action: "new" }
        format.json { render json: @qualification_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qualifications/1
  # PUT /qualifications/1.json
  def update
    @qualification_name = QualificationName.find(params[:id])

    respond_to do |format|
      if @qualification_name.update_attributes(params[:qualification_name])
        format.html { redirect_to qualification_names_path, notice: 'QualificationName was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qualification_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qualifications/1
  # DELETE /qualifications/1.json
  def destroy
    @qualification_name = QualificationName.find(params[:id])
    @qualification_name.destroy

    respond_to do |format|
      format.html { redirect_to qualification_names_url }
      format.json { head :no_content }
    end
  end
end
