class QualificationsController < ApplicationController
  # GET /qualifications
  # GET /qualifications.json
  def index
    @qualifications = Qualification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qualifications }
    end
  end

  # GET /qualifications/1
  # GET /qualifications/1.json
  def show
    @qualification = Qualification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qualification }
    end
  end

  # GET /qualifications/new
  # GET /qualifications/new.json
  def new
    @qualification = Qualification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qualification }
    end
  end

  # GET /qualifications/1/edit
  def edit
    @qualification = Qualification.find(params[:id])
  end

  # POST /qualifications
  # POST /qualifications.json
  def create
    @qualification = Qualification.new(params[:qualification])

    respond_to do |format|
      if @qualification.save
        format.html { redirect_to @qualification, notice: 'Qualification was successfully created.' }
        format.json { render json: @qualification, status: :created, location: @qualification }
      else
        format.html { render action: "new" }
        format.json { render json: @qualification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qualifications/1
  # PUT /qualifications/1.json
  def update
    @qualification = Qualification.find(params[:id])

    respond_to do |format|
      if @qualification.update_attributes(params[:qualification])
        format.html { redirect_to @qualification, notice: 'Qualification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qualification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qualifications/1
  # DELETE /qualifications/1.json
  def destroy
    @qualification = Qualification.find(params[:id])
    @qualification.destroy

    respond_to do |format|
      format.html { redirect_to qualifications_url }
      format.json { head :no_content }
    end
  end
end
