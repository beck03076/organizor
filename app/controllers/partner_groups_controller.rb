class PartnerGroupsController < ApplicationController
  authorize_resource
  # GET /partner_groups
  # GET /partner_groups.json
  def index
    @partner_groups = PartnerGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partner_groups }
    end
  end

  # GET /partner_groups/1
  # GET /partner_groups/1.json
  def show
    @partner_group = PartnerGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner_group }
    end
  end

  # GET /partner_groups/new
  # GET /partner_groups/new.json
  def new
    @partner_group = PartnerGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partner_group }
    end
  end

  # GET /partner_groups/1/edit
  def edit
    @partner_group = PartnerGroup.find(params[:id])
  end

  # POST /partner_groups
  # POST /partner_groups.json
  def create
    @partner_group = PartnerGroup.new(params[:partner_group])

    respond_to do |format|
      if @partner_group.save
        format.html { redirect_to partner_groups_path, notice: 'Partner group was successfully created.' }
        format.json { render json: @partner_group, status: :created, location: @partner_group }
      else
        format.html { render action: "new" }
        format.json { render json: @partner_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partner_groups/1
  # PUT /partner_groups/1.json
  def update
    @partner_group = PartnerGroup.find(params[:id])

    respond_to do |format|
      if @partner_group.update_attributes(params[:partner_group])
        format.html { redirect_to partner_groups_path, notice: 'Partner group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partner_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partner_groups/1
  # DELETE /partner_groups/1.json
  def destroy
    @partner_group = PartnerGroup.find(params[:id])
    @partner_group.destroy

    respond_to do |format|
      format.html { redirect_to partner_groups_url }
      format.json { head :no_content }
    end
  end
end
