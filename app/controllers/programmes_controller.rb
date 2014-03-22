class ProgrammesController < ApplicationController
  include CoreMethods
  include FetchFromContract
  authorize_resource
  # GET /programmes
  # GET /programmes.json
  
  def update_comm_claim
    set_url_params
    authorize! :update, Programme
    
    #@main_ids has programme_ids and asso_id has commission_claim_Status_id
    
    ids = @main_ids.split(",")
    to_update = Programme.where(id: ids)
    @status = CommissionClaimStatus.find(@asso_id).name.titleize

    if @status == "Invoiced"
      iterate_fee(to_update,:invoice_date)
    elsif (@status == "Full Payment Received" || @status == "Partial Payment Received")
      @fp_s_id = CommissionStatus.find_by_name("fully_paid".titleize).id
      @pp_s_id = CommissionStatus.find_by_name("partially_paid".titleize).id
      iterate_fee(to_update,:first_payment_date)
    else
      to_update.update_all(claim_status_id: @asso_id)
      @text = "#{@status} set."
    end
    
    render text: @text

  end
  
  def iterate_fee(objs,col)
    objs.each do |p|
        if p.fee
          if (col == :first_payment_date) && (p.fee.invoice_date.nil?)
            @text = "You cannot set Paid without Invoicing." 
          else 
            p.fee.update_attribute(col,Date.today)
            p.update_attributes(claim_status_id: @asso_id,
                         updated_by: @user_id)
            if (@status == "Full Payment Received")
              stat_id = CommissionStatus.find_by_name("partially paid").id
              p.fee.commissions.where(status_id: stat_id).delete_all
              create_comm(p)
            elsif (@status == "Partial Payment Received")              
              calc_create_comm(p)
            end
            @text = "#{@status} set. #{col.to_s.titleize} Successfully Set."
          end
        else
          @text = "Tuition Fees not updated."
        end
    end
  end
  
  def calc_create_comm(p)
        if p.fee
          if @id_partial_fee[p.fee.id.to_s].present?
              curr_pay = @id_partial_fee[p.fee.id.to_s].to_f * 100
              prev_remain = p.fee.commissions.order(:created_at).last.remaining_cents
              if curr_pay < prev_remain
               s_id = @pp_s_id
              elsif curr_pay == prev_remain
               s_id = @fp_s_id
               c_c_s_id = CommissionClaimStatus.find_by_name("full payment received").id
               p.update_attribute(:claim_status_id,c_c_s_id)
              end
              
              curr_remain = prev_remain - curr_pay
              Commission.create!(paid_cents: curr_pay, 
                                 remaining_cents: curr_remain,
                                 status_id: s_id,
                                 currency: p.fee.currency,
                                 fee_id: p.fee.id)
          end
        end
  end
  
  def create_comm(p)
        if p.fee
          Commission.create!(paid_cents: p.fee.commission_amount_cents, 
                             remaining_cents: 0,
                             status_id: @fp_s_id,
                             currency: p.fee.currency,
                             fee_id: p.fee.id)
        end
  end
  
  def index    
    set_url_params
    self.set_cols
    

    respond_to do |format|

      format.html # index.html.erb
      format.json { core_json("programme",params[:institution_id]) } # in core_methods
      format.js { core_js("programme") } # in core_methods
      format.xls { self.xls_pdf("xls")}
      format.pdf{ self.xls_pdf
      render   :pdf => @filename,
               :layout => 'application',
               :handlers => :erb,
               :disable_external_links => true,
               :print_media_type => true,
               :grayscale => true
      }
    end
  end
  
  def xls_pdf(ext = nil) 
    
    if @prog_ids == "0"
          @programmes = Programme.joined_ins(@ins_id)
    else
          @programmes = Programme.where(id: @prog_ids.split(","))
    end
    @institution = Institution.find(@ins_id)
    
    @filename = @institution.name.tr(" ","_") + "_iecabroad"
    
    headers["Content-Disposition"] = "attachment; filename=\"#{@filename}#{ext.nil? ? nil : ".xls"}\"" 
  end

  def from_institution
    set_url_params
  end
  
  def more
   @programme = Programme.find(params[:id])
   @registration = @programme.registration
   @fee = @programme.fee
   respond_to do |format|
      format.js 
    end
  end
  
  def create_p_fee
    @programme = Programme.find(params[:programme_id])
  end
  
  def change_p_fee_status
    @programme = Programme.find(params[:programme_id])
  end
  
  def show_full
    set_url_params
    out = @model.camelize.constantize.find(@id).send(@col)
    if @volume == "more"
      @to_volume = "less"
      @ctnt = out
    elsif @volume == "less"
      @to_volume = "more"
      @ctnt = out[0..30]
    end

    respond_to do |format|
      format.js 
    end
  end

  # GET /programmes/1
  # GET /programmes/1.json
  def show
    @programme = Programme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @programme }
    end
  end

  # GET /programmes/new
  # GET /programmes/new.json
  def new
    @enquiry = Enquiry.find(params[:id])
    @enquiry.programmes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @programme }
    end
  end

  # GET /programmes/1/edit
  def edit
    @programme = Programme.find(params[:id])
  end

  # POST /programmes
  # POST /programmes.json
  def create

    @programme = Programme.new(params[:programme])

    respond_to do |format|
      if @programme.save
        format.html { redirect_to @programme, notice: 'Programme was successfully created.' }
        format.json { render json: @programme, status: :created, location: @programme }
      else
        format.html { render action: "new" }
        format.json { render json: @programme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programmes/1
  # PUT /programmes/1.json
  def update
    @programme = Programme.find(params[:id])
    
    # the following block decimals up the entered tuition_fee and scholarship and creates a fee for a program 
    if params[:programme][:fee_attributes].present?
        %w(tuition_fee scholarship).each do |s|
          self.set_fee_params(s)
        end
        comm_percentage = fetch_from_contract(params[:id])
        fee = params[:programme][:fee_attributes]
        comm_amount = ((fee[:tuition_fee_cents] - fee[:scholarship_cents]) * (comm_percentage.to_f/100)).to_f
        params[:programme][:fee_attributes][:commission_amount_cents] = comm_amount
        params[:programme][:fee_attributes][:commission_percentage] = comm_percentage
        
    end

    respond_to do |format|
      if @programme.update_attributes(params[:programme])
        # first pending commmission is created here
        @commissions = @programme.fee.commissions rescue ""
        if (params[:programme][:fee_attributes])
          @commissions.delete_all
          s_id = CommissionStatus.find_by_name("pending".titleize).id
          Commission.create!(status_id: s_id,
                             paid_cents: 0,
                             fee_id: @programme.fee.id,
                             remaining_cents: params[:programme][:fee_attributes][:commission_amount_cents],
                             currency: params[:programme][:fee_attributes][:currency])
        end
        
        if (params[:programme][:notes_attributes])
          
          tl("Registration",@programme.registration.id,'A note to a programme has been created for this registration',
             "#{(@programme.institution.name rescue "Unknown")}",'Note',@programme.registration.assigned_to)
            
        end
      
        format.html { redirect_to @programme.registration, notice: 'Programme was successfully updated.' }
        format.json { head :no_content }
        if params[:programme][:fee_attributes].present?
          format.js { render "programmes/fee_update" }
        elsif !params[:change_p_fee_status].nil?
          format.js { render "programmes/change_p_fee_status" }
        elsif params[:change_status].nil?
          format.js { render "programmes/update" }
        else
          tl("Registration",
             @programme.registration.id,
             'Status of an application has been changed for this registration',
             "#{(@programme.institution.name rescue "Unknown")}",
             'StatusChange',
             @programme.registration.assigned_to)
             
          format.js { render "application_statuses/update" } 
          
        end   
      else
        format.html { render action: "edit" }
        format.json { render json: @programme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programmes/1
  # DELETE /programmes/1.json
  def destroy
    @programme = Programme.find(params[:id])
    @programme.destroy

    respond_to do |format|
      format.html { redirect_to @programme.registration }
      format.json { head :no_content }
    end
  end
  
  def set_fee_params(s)
    ss = s.to_sym
    params[:programme][:fee_attributes][(s + '_cents').to_sym] = parse_amt(params[:programme][:fee_attributes][ss])
    params[:programme][:fee_attributes].delete(ss)
  end  
  
  def set_cols
     # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.pro_cols
      b = [:surname,:first_name]
      @cols = ((b & a) + (a - b))
  end
  
  def parse_amt(i)
   i.tr(',','').to_f * 100
  end
  
  

end
