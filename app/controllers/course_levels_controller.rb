class CourseLevelsController < ApplicationController
  authorize_resource
  # GET /course_levels
  # GET /course_levels.json
  def index
    @course_levels = CourseLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @course_levels.map(&:attributes) }
    end
  end

  # GET /course_levels/1
  # GET /course_levels/1.json
  def show
    @course_level = CourseLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_level }
    end
  end

  # GET /course_levels/new
  # GET /course_levels/new.json
  def new
    @course_level = CourseLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_level }
    end
  end

  # GET /course_levels/1/edit
  def edit
    @course_level = CourseLevel.find(params[:id])
  end

  # POST /course_levels
  # POST /course_levels.json
  def create
    @course_level = CourseLevel.new(params[:course_level])

    respond_to do |format|
      if @course_level.save
        format.html { redirect_to course_levels_path, notice: 'Course level was successfully created.' }
        format.json { render json: @course_level, status: :created, location: @course_level, course_levels: CourseLevel.all }
      else
        format.html { render action: "new" }
        format.json { render json: @course_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_levels/1
  # PUT /course_levels/1.json
  def update
    @course_level = CourseLevel.find(params[:id])

    respond_to do |format|
      if @course_level.update_attributes(params[:course_level])
        format.html { redirect_to course_levels_path, notice: 'Course level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_levels/1
  # DELETE /course_levels/1.json
  def destroy
    @course_level = CourseLevel.find(params[:id])
    @course_level.destroy

    respond_to do |format|
      format.html { redirect_to course_levels_url }
      format.json { head :no_content }
    end
  end
end
