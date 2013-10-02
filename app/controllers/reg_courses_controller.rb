class RegCoursesController < ApplicationController
  # GET /reg_courses
  # GET /reg_courses.json
  def index
    @reg_courses = RegCourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reg_courses }
    end
  end

  # GET /reg_courses/1
  # GET /reg_courses/1.json
  def show
    @reg_course = RegCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reg_course }
    end
  end

  # GET /reg_courses/new
  # GET /reg_courses/new.json
  def new
    @reg_course = RegCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reg_course }
    end
  end

  # GET /reg_courses/1/edit
  def edit
    @reg_course = RegCourse.find(params[:id])
  end

  # POST /reg_courses
  # POST /reg_courses.json
  def create
    @reg_course = RegCourse.new(params[:reg_course])

    respond_to do |format|
      if @reg_course.save
        format.html { redirect_to @reg_course, notice: 'Reg course was successfully created.' }
        format.json { render json: @reg_course, status: :created, location: @reg_course }
      else
        format.html { render action: "new" }
        format.json { render json: @reg_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reg_courses/1
  # PUT /reg_courses/1.json
  def update
    @reg_course = RegCourse.find(params[:id])

    respond_to do |format|
      if @reg_course.update_attributes(params[:reg_course])
        format.html { redirect_to @reg_course, notice: 'Reg course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reg_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reg_courses/1
  # DELETE /reg_courses/1.json
  def destroy
    @reg_course = RegCourse.find(params[:id])
    @reg_course.destroy

    respond_to do |format|
      format.html { redirect_to reg_courses_url }
      format.json { head :no_content }
    end
  end
end
