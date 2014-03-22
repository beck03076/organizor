class FeesController < ApplicationController

  def create_fee
    @programme = Programme.find(params[:programme_id])
  end
  # GET /fees
  # GET /fees.json
  def index
    @fees = Fee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fees }
    end
  end

  # GET /fees/1
  # GET /fees/1.json
  def show
    @fee = Fee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fee }
    end
  end

  # GET /fees/new
  # GET /fees/new.json
  def new
    @fee = Fee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fee }
      format.js
    end
  end

  # GET /fees/1/edit
  def edit
    @fee = Fee.find(params[:id])
  end

  # POST /fees
  # POST /fees.json
  def create
    @fee = Fee.new(params[:fee])

    respond_to do |format|
      if @fee.save
        format.html { redirect_to @fee.registration, notice: 'Fee was successfully created.' }
        format.json { render json: @fee, status: :created, location: @fee }
      else
        format.html { render action: "new" }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fees/1
  # PUT /fees/1.json
  def update
    @fee = Fee.find(params[:id])
    
    %w(tuition_fee scholarship commission_amount).each do |s|
       self.set_fee_params(s)
    end

    respond_to do |format|
      if @fee.update_attributes(params[:fee])
        @commissions = @fee.commissions
        if (!@commissions.blank?)
          @commissions.delete_all
          s_id = CommissionStatus.find_by_name("pending".titleize).id
          Commission.create!(status_id: s_id,
                             paid_cents: 0,
                             fee_id: @fee.id,
                             remaining_cents: params[:fee][:commission_amount_cents],
                             currency: params[:fee][:currency])
        end
        format.html { redirect_to @fee.registration, notice: 'Fee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    @fee = Fee.find(params[:id])
    @reg = @fee.registration
    @programme = @fee.programme
    @programme.update_attribute(:claim_status_id,nil)
    @fee.destroy

    respond_to do |format|
      format.html { redirect_to @reg }
      format.json { head :no_content }
    end
  end
  
  def set_fee_params(s)
    ss = s.to_sym
    params[:fee][(s + '_cents').to_sym] = params[:fee][ss].tr(',','').to_f * 100
    params[:fee].delete(ss)
  end
  
end
