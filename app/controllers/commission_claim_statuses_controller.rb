class CommissionClaimStatusesController < ApplicationController
  authorize_resource
  # GET /commission_claim_statuses
  # GET /commission_claim_statuses.json
  def index
    @commission_claim_statuses = CommissionClaimStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commission_claim_statuses }
    end
  end

  # GET /commission_claim_statuses/1
  # GET /commission_claim_statuses/1.json
  def show
    @commission_claim_status = CommissionClaimStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commission_claim_status }
    end
  end

  # GET /commission_claim_statuses/new
  # GET /commission_claim_statuses/new.json
  def new
    @commission_claim_status = CommissionClaimStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commission_claim_status }
    end
  end

  # GET /commission_claim_statuses/1/edit
  def edit
    @commission_claim_status = CommissionClaimStatus.find(params[:id])
  end

  # POST /commission_claim_statuses
  # POST /commission_claim_statuses.json
  def create
    @commission_claim_status = CommissionClaimStatus.new(params[:commission_claim_status])

    respond_to do |format|
      if @commission_claim_status.save
        format.html { redirect_to commission_claim_statuses_path, notice: 'Commission claim status was successfully created.' }
        format.json { render json: @commission_claim_status, status: :created, location: @commission_claim_status }
      else
        format.html { render action: "new" }
        format.json { render json: @commission_claim_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commission_claim_statuses/1
  # PUT /commission_claim_statuses/1.json
  def update
    @commission_claim_status = CommissionClaimStatus.find(params[:id])

    respond_to do |format|
      if @commission_claim_status.update_attributes(params[:commission_claim_status])
        format.html { redirect_to commission_claim_statuses_path, notice: 'Commission claim status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commission_claim_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commission_claim_statuses/1
  # DELETE /commission_claim_statuses/1.json
  def destroy
    @commission_claim_status = CommissionClaimStatus.find(params[:id])
    @commission_claim_status.destroy

    respond_to do |format|
      format.html { redirect_to commission_claim_statuses_url }
      format.json { head :no_content }
    end
  end
end
