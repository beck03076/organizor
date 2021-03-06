class RegistrationsController < ApplicationController


  def basic_select(model,cond = true)
    model.where(cond).order(:name).map{|i| [i.name,i.id]}
  end
  # GET /registrations
  # GET /registrations.json
  def index
   set_url_params

    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => RegistrationsDatatable.new(view_context,eval(@sCols),@sFilter)}
    end
  end

   def tab
    set_url_params
    
    if @status == "new_registration"
      self.h_new
    elsif @status == "launch"
      @registration = Registration.find(@registration_id)
      @timelines = Timeline.where(m_name: "Registration", m_id: params[:registration_id]).order("created_at DESC")
    elsif @status == "edit"
      @registration = Registration.find(params[:registration_id])
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
    elsif @status == "clone"
      self.set_ref_no
      orig = Registration.find(params[:registration_id])
      @registration = orig.dup :include => [:programmes, :exams]
      @registration.ref_no = @ref_no
      authorize! :create, @registration
      
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
    else
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.reg_cols
      b = [:id,:ref_no,:first_name,:surname,:mobile1,:email1,:gender,:date_of_birth]
      @cols = ((b & a) + (a - b)) + [:follow_up_date] 
    end
    
    render partial: @partial

  end
  
    
  def action_partial
    set_url_params
    @registration = Registration.find(@registration_id)
    
    if @partial_name == "follow_up"
          @d_f_u_days = current_user.conf.def_follow_up_days
          @follow_up = FollowUp.new(title: "First Follow Up", 
                                    desc: "This enquiry does not have an update, yet!.
                                           Should call this enquiry in 2 days.")

    elsif @partial_name == "note"
          @d_note = current_user.conf.def_note
          @note = Note.new(content: @d_note)
          
    elsif @partial_name == "todo"
          @todo = Todo.new
    end
    
    if @partial_name == "email"
      mail_to_use = current_user.conf.def_reg_email.to_sym
      
      @subject = Registration.where(id: @registration_id)
      @subject_ids = (@subject.map &:id).join(",")
      @email_to = ((@subject.map &mail_to_use) - ["",nil]).join(", ")
      render :partial => 'enquiries/email', :locals => {:e => Email.new(to: @email_to), 
                                                     :id => params[:e_id],
                                                     :obj => @subject,
                                                     :obj_ids => "registration_ids",
                                                     :obj_name => "registration" }
    else
     render :partial => "enquiries/" + @partial_name.to_s ,:locals => {:e => Email.new,
                                                                      :id => @registration_id,
                                                                      :obj => @registration,
                                                                      :obj_id => :registration_id,
                                                                      :obj_name => "registration"}
    end
     
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])
    authorize! :read, @registration
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    #self.h_new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end
  
  def clone
    @registration = Registration.find(params[:id])
    authorize! :create, @registration
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
    authorize! :update, @registration
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])
    authorize! :create, @registration

    respond_to do |format|
      if @registration.save
        if @registration.enquiry_id
          Enquiry.find(@registration.enquiry_id).update_attribute(:registered, true)
          tl("Registration",@registration.id,
             'An enquiry has been registered',"Registered",
             "registration",@registration.assigned_to)
        end
        if params[:save_new] 
          format.html { redirect_to new_registration_path, notice: 'Registration was successfully created.' }
        else
          format.html { redirect_to @registration }
          format.json { render json: @registration, status: :created, location: @registration }
        end  
      else
        format.html { render action: "new" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])
    authorize! :update, @registration
    
    respond_to do |format|
      if @registration.update_attributes(params[:registration].except("assign"))
      
        if (params[:registration][:assign].to_s == "from_action")
    
          ass_to = User.find(params[:registration][:assigned_to]).first_name
          ass_by = User.find(params[:registration][:assigned_by]).first_name
          
          tl("Registration",params[:id],'This registration has been reassigned',
              'Assigned To: ' + ass_to + ' | Assigned By: ' + ass_by,'assign_to',params[:registration][:assigned_to])
        
        elsif params[:registration][:notes_attributes]
          tl("Registration",params[:id],'A note has been created for this registration',
             "Note created",'note',@registration.assigned_to)
             
        elsif params[:registration][:documents_attributes]
          doc_no = params[:registration][:documents_attributes].size
          tl("Registration",params[:id],"#{doc_no} document(s) has been uploaded to this registration",
             "Docs Uploaded",'document',@registration.assigned_to)
             
        else
        
          tl("Registration",params[:id],'Values of this registration has been updated',
             "Updated",'Update',@registration.assigned_to)
        end
              
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    authorize! :destroy, @registration
    
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end
  
  # h_new stands for help_new
  def h_new
      self.set_ref_no
      if params[:enquiry_id]
                  # e stands for enquiry
                  e_obj = Enquiry.find(params[:enquiry_id])
                  deact = EnquiryStatus.find_by_name("deactivated").id
                  # deactivate the enquiry as it is going to be registered
                  e_obj.update_attributes(active: false,
                                          audit_comment: params[:note].to_s,
                                          status_id: deact)
                  #create a timeline item
                  tl("Enquiry",params[:enquiry_id],
                     'This enquiry has been deactivated in order to register',(params[:note] || "Deactivated"),
                     "Deactivated",e_obj.assigned_to)
                                   
                  e = e_obj.attributes.except("id","score","source_id",
                                              "created_at","updated_at",
                                              "status_id", "address",
                                              "active","contact_type_id",
                                              "registered")
                  e[:note] = params[:note]
                  @enquiry_id = params[:enquiry_id]
                  @registration = Registration.new(e)
                  authorize! :create, @registration
                  
                  if !e_obj.programmes.blank?
                    @registration.programmes << e_obj.programmes
                  end
      else
                  @registration = Registration.new(assigned_to: current_user.id,
                                                   date_of_birth: (Date.today - 21.years),
                                                   gender: "m")
                  authorize! :create, @registration
      end
      
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
  end
  
  def set_ref_no
    # creating new reference number logic
        ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
        ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s[4..7]
        ym = Time.now.strftime("%y%m").to_s
        @ref_no = ym + "%04d" % (ref_temp_no.to_i + 1)
  end
  
end
