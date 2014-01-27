class SmtpsController < ApplicationController
  # GET /smtps
  # GET /smtps.json
  def index
    @smtps = Smtp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @smtps }
    end
  end

  # GET /smtps/1
  # GET /smtps/1.json
  def show
    @smtp = Smtp.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render json: @smtp }
    end
  end

  # GET /smtps/new
  # GET /smtps/new.json
  def new
    @smtp = Smtp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @smtp }
    end
  end

  # GET /smtps/1/edit
  def edit
    @smtp = Smtp.find(params[:id])
  end

  # POST /smtps
  # POST /smtps.json
  def create
    @smtp = Smtp.new(params[:smtp])

    respond_to do |format|
      if @smtp.save
        format.html { redirect_to smtps_path, notice: 'Smtp was successfully created.' }
        format.json { render json: @smtp, status: :created, location: @smtp }
      else
        format.html { render action: "new" }
        format.json { render json: @smtp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /smtps/1
  # PUT /smtps/1.json
  def update
    @smtp = Smtp.find(params[:id])

    respond_to do |format|
      if @smtp.update_attributes(params[:smtp])
        format.html { redirect_to smtps_path, notice: 'Smtp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @smtp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smtps/1
  # DELETE /smtps/1.json
  def destroy
    @smtp = Smtp.find(params[:id])
    @smtp.destroy

    respond_to do |format|
      format.html { redirect_to smtps_url }
      format.json { head :no_content }
    end
  end
end
