class CommissionsController < ApplicationController
  include FetchFromContract
  
  def partial_fee
    set_url_params
    @programmes = Programme.where(id: @prog_ids)
    respond_to do |format|
      format.js
    end
  end
  
  def fetch_contract
    comm_percentage = fetch_from_contract(params[:prog_id])
    render text: comm_percentage
  end
  
  def new
    @payment = Payment.find(params[:payment_id])
    stat = CommissionStatus.find_by_name("partially paid").id
    curr = @payment.currency
    @commission = Commission.new(payment_id: @payment.id,
                                 date_received: Date.today,
                                 status_id: stat,
                                 currency: curr)
  end
  
  # POST /commission.json
  def create
    @commission = Commission.new(params[:commission])
    @payment = @commission.payment
    @payment_all_comm = @payment.all_comm
    
    comm_curr_and_prev = (@payment_all_comm + params[:commission][:paid].to_f)
    
    # check whether all the commission amount sums up and not be greater than or equal the amount payable
    eval_comm_greater = (comm_curr_and_prev > @payment.amount)
    eval_comm_equal = (comm_curr_and_prev == @payment.amount)
    
    stat = CommissionStatus.find_by_name("fully paid").id
    
    if (eval_comm_equal && (params[:commission][:status_id].to_i !=  stat))
      @flag = "full_paid"
    elsif !(eval_comm_greater)
      @registration = @payment.programme.registration
      @commission.save!
      @flag = "normal"
    else
      @flag = "only_last"
    end
    respond_to do |format|
      format.js
    end
  end
  
  # DELETE /commissions/1
  # DELETE /commissions/1.json
  def destroy
    @commission = Commission.find(params[:id])
    @commission.destroy
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
