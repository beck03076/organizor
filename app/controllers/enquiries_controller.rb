class EnquiriesController < ApplicationController
  include CoreMethods
  
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
    set_url_params
    self.set_cols
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("enquiry") } # in core_methods
      format.js { core_js("enquiry") } # in core_methods
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
    @p_types = InstitutionType.where(educational: true)
  end
  

  def clone
    # To have this next line, is to display the enquiry name on the tab, thats all
    @enquiry = Enquiry.find(params[:id])
    authorize! :create, @enquiry
  end

  # GET /enquiries/1/edit
  def edit
    @enquiry = Enquiry.find(params[:id])
    authorize! :update, @enquiry
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
      
        tl('Enquiry',@enquiry.id,
            "A new enquiry has been created",
            @enquiry.first_name,'Create Enquiry',@enquiry.assigned_to)
        # after creating enquiry, checking conf for email and f_u
        c = current_user.conf
        
        if c.auto_email_enq
          temp = c.def_create_enquiry_email
          to = c.def_enq_email
          etemp = EmailTemplate.find_by_name(temp)

          @enquiry.emails.create(subject: etemp.subject,
                                 body: etemp.body,
                                 signature: etemp.signature,
                                 to: @enquiry.send(to),
                                 from: c.def_from_email)
                                 
           tl('Enquiry',@enquiry.id,
              "An email has been sent to this enquiry",
              etemp.subject,'email',@enquiry.assigned_to)
        end
        
        if c.auto_cr_f_u
          s = (Date.today + c.def_follow_up_days.to_i)
          @enquiry.follow_ups.create(title: c.def_f_u_name,
                                     desc: c.def_f_u_desc,
                                     event_type_id: c.def_f_u_type,
                                     starts_at: s,
                                     ends_at: s + 1,
                                     assigned_to: c.def_f_u_ass_to,
                                     assigned_by: current_user.id)
           tl('Enquiry',@enquiry.id,
              "A follow up has been created for this enquiry",
              c.def_f_u_name.to_s + ' at ' + s.to_s + ' | assigned(follow up) to: ' + c.def_f_u_ass_to.to_s,'follow_up',c.def_f_u_ass_to)
        end

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
        
         if (params[:enquiry][:assign].to_s == "from_action")
    
          ass_to = User.find(params[:enquiry][:assigned_to]).first_name
          ass_by = User.find(params[:enquiry][:assigned_by]).first_name
        
          tl("Enquiry",params[:id],'This enquiry has been reassigned',
             'Assigned To: ' + ass_to + ' | Assigned By: ' + ass_by,
             'assign_to',@enquiry.assigned_to)
                           
        elsif (params[:enquiry][:deactivate].to_s == "from_action")
        
          tl("Enquiry",params[:id],'This enquiry has been deactivated',
             "Deactivated",'deactivate',@enquiry.assigned_to)
             
        elsif params[:enquiry][:active].to_s == 'true'
          
          tl("Enquiry",params[:id],'This enquiry has been activated',
             "Activated",'activate',@enquiry.assigned_to)
             
        elsif params[:enquiry][:notes_attributes]
              tl("Enquiry",params[:id],'A note has been created for this enquiry',
                 "Note created",'note',@enquiry.assigned_to) 
        
        else
        
          tl("Enquiry",params[:id],'Values of this enquiry has been updated',
             "Updated",'Update',@enquiry.assigned_to)
        end
        
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
      b = [:id,:first_name,:surname,:mobile1,:email1,:gender,:date_of_birth]
      @cols = ((b & a) + (a - b)) + [:follow_up_date]   
      p "************"
      p  @cols
  end
  
end
