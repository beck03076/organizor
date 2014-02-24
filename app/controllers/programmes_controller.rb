class ProgrammesController < ApplicationController
  include CoreMethods
  include FetchFromContract
  authorize_resource
  # GET /programmes
  # GET /programmes.json
  
  def update_comm_claim
    set_url_params
    authorize! :update, Programme
    
    ids = params[:prog_ids].split(",")
    
    to_update = Programme.where(id: ids)
    to_update.update_all(claim_status_id: params[:status_id],
                         updated_by: params[:user_id])
                         
    status = CommissionClaimStatus.find(params[:status_id]).name.titleize
    
    @text = "Status Successfully Changed."
    
    if status == "Invoiced"
      iterate_fee(to_update,:invoice_date)
      @text += " To #{status}. Invoice Date Successfully Set."
    elsif (status == "Full Payment Received" || status == "Partial Payment Received")
      iterate_fee(to_update,:first_payment_date)
      @text += " To #{status}. First Payment Date Successfully Set."
    else
      @text += " To #{status}."
    end
                         
    render text: @text
  end
  
  def iterate_fee(objs,col)
    objs.each do |p|
        if p.fee
          if col == :first_payment_date && !p.fee.invoice_date.nil?
            p.fee.update_attribute(col,Date.today)
          else
            @text = " You cannot set Paid without Invoicing."
          end
        end
    end
  end
  
  def index    
    set_url_params
    self.set_cols

    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("programme",params[:institution_id]) } # in core_methods
      format.js { core_js("programme") } # in core_methods
    end
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
    
    # the following block decimals up the entered tuition_fee and scholarship
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
        if (params[:programme][:notes_attributes])
          
          tl("Registration",@programme.registration.id,'A note to a programme has been created for this registration',
             "#{(@programme.institution.name rescue "Unknown")}",'Note',@programme.registration.assigned_to)
            
        end
      
        format.html { redirect_to @programme.registration, notice: 'Programme was successfully updated.' }
        format.json { head :no_content }
        
        if params[:change_status].nil?
          format.js { render "programmes/update" }
        else
        
          StatusDiagram.create!(user_id: current_user.id,
                                status_id: params[:programme][:app_status_id],
                                programme_id: params[:id])
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
    params[:programme][:fee_attributes][(s + '_cents').to_sym] = params[:programme][:fee_attributes][ss].tr(',','').to_f * 100
    params[:programme][:fee_attributes].delete(ss)
  end  
  
  def set_cols
     # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.pro_cols
      b = [:surname,:first_name]
      @cols = ((b & a) + (a - b))
      p "*****************88"
      p @cols
  end
  
  

end
