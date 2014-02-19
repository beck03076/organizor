class SlidingScalesController < ApplicationController

  # GET /sliding_scales
  # GET /sliding_scales.json
  def collective
    set_url_params

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sliding_scales }
      format.js
    end
  end
  
  # GET /sliding_scales
  # GET /sliding_scales.json
  def index
    @sliding_scales = SlidingScale.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sliding_scales }
    end
  end

  # GET /sliding_scales/1
  # GET /sliding_scales/1.json
  def show
    @sliding_scale = SlidingScale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sliding_scale }
    end
  end

  # GET /sliding_scales/new
  # GET /sliding_scales/new.json
  def new
    @sliding_scale = SlidingScale.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sliding_scale }
    end
  end

  # GET /sliding_scales/1/edit
  def edit
    @sliding_scale = SlidingScale.find(params[:id])
  end

  # POST /sliding_scales
  # POST /sliding_scales.json
  def create
    @sliding_scale = SlidingScale.new(params[:sliding_scale])

    respond_to do |format|
      if @sliding_scale.save
        format.html { redirect_to @sliding_scale, notice: 'Sliding scale was successfully created.' }
        format.json { render json: @sliding_scale, status: :created, location: @sliding_scale }
      else
        format.html { render action: "new" }
        format.json { render json: @sliding_scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sliding_scales/1
  # PUT /sliding_scales/1.json
  def update
    @sliding_scale = SlidingScale.find(params[:id])

    respond_to do |format|
      if @sliding_scale.update_attributes(params[:sliding_scale])
        format.html { redirect_to @sliding_scale, notice: 'Sliding scale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sliding_scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sliding_scales/1
  # DELETE /sliding_scales/1.json
  def destroy
    @sliding_scale = SlidingScale.find(params[:id])
    @sliding_scale.destroy

    respond_to do |format|
      format.html { redirect_to sliding_scales_url }
      format.json { head :no_content }
    end
  end
end
