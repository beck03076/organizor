class EnquiriesController < ApplicationController


  include CoreController
  include ActionsMethods
  helper_method :meta  
  
  def tab
    set_url_params    
    self.set_cols
    render partial: @partial
  end
  
  def action_partial
    set_url_params
    #called from CoreMethods, 3rd param is the native partials to enquiries
    h_action_partial("enquiry",params[:enquiry_id],["register","deactivate"])
  end
  
  # GET /enquiries
  # GET /enquiries.json
  def index
    authorize! :list, Enquiry
    set_url_params
    self.set_cols
    
    @tab_type ||= "EnquiryStatus"

    set_tab_value

    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("enquiry",nil,@tab_type) } # in core_methods
      format.js { core_js("enquiry",nil,@tab_type) } # in core_methods
      format.xls
    end
  end



  # GET /enquiries/1
  # GET /enquiries/1.json
  def show
    @enquiry = Enquiry.find(params[:id])
    authorize! :read, @enquiry
        
    # showing basic by default
    @partial = "basic"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render partial: 'show'}
    end
  end

  # GET /enquiries/new
  # GET /enquiries/new.json
  def new
    @enquiry = Enquiry.new(assigned_to: current_user.id,
                           date_of_birth: (Date.today - 21.years),
                           gender: "m",
                           score: 5)
    authorize! :create, @enquiry
      
    @countries = basic_select(Country)
    @p_types = PartnerType.where(educational: true)
  end
  

  def clone
    # To have this next line, is to display the enquiry name on the tab, thats all
    @enquiry = Enquiry.find(params[:id]).deep_clone
    authorize! :create, @enquiry

    @countries = basic_select(Country)
    @p_types = PartnerType.where(educational: true)
  end

  # GET /enquiries/1/edit
  def edit
    @enquiry = Enquiry.find(params[:id])
    authorize! :update, @enquiry
    
    @countries = basic_select(Country)
    @p_types = PartnerType.where(educational: true)
  end

  # POST /enquiries
  # POST /enquiries.json
  def create
    @enquiry = Enquiry.new(params[:enquiry])
    authorize! :create, @enquiry
     
    stat_id = EnquiryStatus.find_by_name("pending").id
    @enquiry.status_id = stat_id
    
    respond_to do |format|
      
      if @enquiry.save      

        if params[:save_new] 
          format.html { redirect_to new_enquiry_path, notice: 'Enquiry was successfully created.' }
        else
          format.html { redirect_to @enquiry, notice: 'Enquiry was successfully created.' }
          format.json { render json: @enquiry, status: :created, location: @enquiry }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @enquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /enquiries/1
  # PUT /enquiries/1.json
  def update
    @enquiry = Enquiry.find(params[:id])
    authorize! :update, @enquiry
    
    if params[:enquiry][:active].to_s == 'false'
       params[:enquiry][:status_id] = EnquiryStatus.find_by_name("deactivated").id
    elsif params[:enquiry][:active].to_s == 'true'
       params[:enquiry][:status_id] = EnquiryStatus.find_by_name("pending").id
    end
    
    respond_to do |format|
      if @enquiry.update_attributes(params[:enquiry].except("assign","deactivate"))
        
        format.html { redirect_to @enquiry, notice: 'Enquiry was successfully updated.' }
        format.json { head :ok, notice: "Enquiry was successfully updated." }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @enquiry.errors, status: :unprocessable_entity }
        
      end
    end
  end

  # DELETE /enquiries/1
  # DELETE /enquiries/1.json
  def destroy
    @enquiry = Enquiry.find(params[:id])
    authorize! :destroy, @enquiry
    
    stat = EnquiryStatus.find_by_name("deactivated").id
    @enquiry.update_attributes(status_id: stat,active: false)
    
    tl("Enquiry",params[:id],'This enquiry has been deactivated',
                 "Deactivated",'deactivate',@enquiry.assigned_to)

    respond_to do |format|
      format.html { redirect_to enquiries_path, notice: 'Enquiry was successfully deactivated.' }
      format.json { head :no_content }
    end
  end
  
  def set_cols
     # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.enq_cols
      b = [:id,:first_name,:surname,:mobile1,:email,:gender,:date_of_birth]
      @cols = ((b & a) + (a - b)) + [:follow_up_date]   
  end
  
end
