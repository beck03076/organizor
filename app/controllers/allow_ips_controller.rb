class AllowIpsController < ApplicationController
  authorize_resource
  # GET /allow_ips
  # GET /allow_ips.json
  def index
    @allow_ips = AllowIp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @allow_ips }
    end
  end

  # GET /allow_ips/1
  # GET /allow_ips/1.json
  def show
    @allow_ip = AllowIp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @allow_ip }
    end
  end

  # GET /allow_ips/new
  # GET /allow_ips/new.json
  def new
    @allow_ip = AllowIp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @allow_ip }
    end
  end

  # GET /allow_ips/1/edit
  def edit
    @allow_ip = AllowIp.find(params[:id])
  end

  # POST /allow_ips
  # POST /allow_ips.json
  def create
    @allow_ip = AllowIp.new(params[:allow_ip])

    respond_to do |format|
      if @allow_ip.save
        format.html { redirect_to allow_ips_path, notice: 'Allow ip was successfully created.' }
        format.json { render json: @allow_ip, status: :created, location: @allow_ip }
      else
        format.html { render action: "new" }
        format.json { render json: @allow_ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /allow_ips/1
  # PUT /allow_ips/1.json
  def update
    @allow_ip = AllowIp.find(params[:id])

    respond_to do |format|
      if @allow_ip.update_attributes(params[:allow_ip])
        format.html { redirect_to allow_ips_path, notice: 'Allow ip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @allow_ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allow_ips/1
  # DELETE /allow_ips/1.json
  def destroy
    @allow_ip = AllowIp.find(params[:id])
    @allow_ip.destroy

    respond_to do |format|
      format.html { redirect_to allow_ips_url }
      format.json { head :no_content }
    end
  end
end
