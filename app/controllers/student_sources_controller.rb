class StudentSourcesController < ApplicationController
  authorize_resource
  # GET /student_sources
  # GET /student_sources.json
  def index
    @student_sources = StudentSource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @student_sources }
    end
  end

  # GET /student_sources/1
  # GET /student_sources/1.json
  def show
    @student_source = StudentSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student_source }
      format.js
    end
  end

  # GET /student_sources/new
  # GET /student_sources/new.json
  def new
    @student_source = StudentSource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student_source }
    end
  end

  # GET /student_sources/1/edit
  def edit
    @student_source = StudentSource.find(params[:id])
  end

  # POST /student_sources
  # POST /student_sources.json
  def create
    @student_source = StudentSource.new(params[:student_source])

    respond_to do |format|
      if @student_source.save
        format.html { redirect_to student_sources_path, notice: 'Student source was successfully created.' }
        format.json { render json: @student_source, status: :created, location: @student_source }
      else
        format.html { render action: "new" }
        format.json { render json: @student_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /student_sources/1
  # PUT /student_sources/1.json
  def update
    @student_source = StudentSource.find(params[:id])

    respond_to do |format|
      if @student_source.update_attributes(params[:student_source])
        format.html { redirect_to student_sources_path, notice: 'Student source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_sources/1
  # DELETE /student_sources/1.json
  def destroy
    @student_source = StudentSource.find(params[:id])
    @student_source.destroy

    respond_to do |format|
      format.html { redirect_to student_sources_url }
      format.json { head :no_content }
    end
  end
end
