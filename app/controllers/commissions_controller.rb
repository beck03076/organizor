class CommissionsController < ApplicationController

  def fetch_contract
    # p for programme, i for institution and r_ids for registration_ids
    p = Programme.find(params[:prog_id])
    i = p.institution
    # how manieth registration is this for this institution is r_order
    r_id = [p.registration.id]
    r_ids = i.registrations.map &:id
    r_arr = (r_ids - r_id)
    r_order = (r_arr).blank? ? 1 : (r_arr.size + 1)
    
        # ss stands for sliding scales, assuming only one contract per institution    
        ss = i.contracts.first.sliding_scales
        # case where there is not sliding scale at all
        if ss.nil?
          @out = "No Sliding Scale Configured!"
        elsif !ss.nil? 
          # case where there is sliding scale but without course_levels
          if (ss.map &:course_level_name).flatten.blank?          
            range_array = ss.map{|i| [i.from,i.to,i.commission_percentage] }
            # this prepares from nil situations(50+) and checks if the r_order is in between a range and sets the right percentage
            self.check_range(range_array,r_order)
          # case where there is sliding scale but with course_levels
          else
            ss_cls = ss.map {|i| [i.id,i.course_level_name,[i.from,i.to,i.commission_percentage]]}    
            range_array = ss_cls.map {|i| i[1].include?(p.course_level_name) ? i[2] : nil  }.compact    
            self.check_range(range_array,r_order)
          end
        end

    render text: @out
  end
  
  def check_range(range_arr,order)
    clean_range_arr = self.from_plus(range_arr)
    clean_range_arr.each do |i|
      if order.between?((i[0] - 1),i[1])
       @out = i[2]
       break
      end
    end
    @out = @out.blank? ? "Not in(Over/Below) Student Range" : @out
  end
  
  def from_plus(arr)
    final = []
    arr.each do |i|
      if !i[1].nil?
        if i[0].nil?
          final << [i[1],1000000,i[2]]
        else
          final << i
        end  
      end
    end
    final
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
    @payment = @commission.payment
    
    last_commission_id = @payment.commissions.order("created_at desc").first.id
    
    if last_commission_id == @commission.id
      @registration = @payment.programme.registration
      @commission.destroy
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
