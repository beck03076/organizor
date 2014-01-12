class PaymentsController < ApplicationController

  def new
    @programme_id = params[:programme_id]
    @programme = Programme.find(@programme_id)
    @comm_rate = @programme.institution.contracts.where(commission_specified: true).first.commission_rate rescue nil
    
  end
  
  # POST /payment.json
  def create
    @payment = Payment.new(params[:payment])
    @registration = Programme.find(params[:payment][:programme_id]).registration

    respond_to do |format|
      if @payment.save
        format.js
      end
    end
  end
  
  
  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    
    @registration = @payment.programme.registration
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
