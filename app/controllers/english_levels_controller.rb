class EnglishLevelsController < ApplicationController
  authorize_resource
  # GET /english_levels
  # GET /english_levels.json
  def index
    @english_levels = EnglishLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @english_levels }
    end
  end

  # GET /english_levels/1
  # GET /english_levels/1.json
  def show
    @english_level = EnglishLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @english_level }
    end
  end

  # GET /english_levels/new
  # GET /english_levels/new.json
  def new
    @english_level = EnglishLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @english_level }
    end
  end

  # GET /english_levels/1/edit
  def edit
    @english_level = EnglishLevel.find(params[:id])
  end

  # POST /english_levels
  # POST /english_levels.json
  def create
    @english_level = EnglishLevel.new(params[:english_level])

    respond_to do |format|
      if @english_level.save
        format.html { redirect_to english_levels_path, notice: 'English level was successfully created.' }
        format.json { render json: @english_level, status: :created, location: @english_level }
      else
        format.html { render action: "new" }
        format.json { render json: @english_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /english_levels/1
  # PUT /english_levels/1.json
  def update
    @english_level = EnglishLevel.find(params[:id])

    respond_to do |format|
      if @english_level.update_attributes(params[:english_level])
        format.html { redirect_to @english_level, notice: 'English level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @english_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /english_levels/1
  # DELETE /english_levels/1.json
  def destroy
    @english_level = EnglishLevel.find(params[:id])
    @english_level.destroy

    respond_to do |format|
      format.html { redirect_to english_levels_url }
      format.json { head :no_content }
    end
  end
end
