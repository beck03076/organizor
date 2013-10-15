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
       ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
    
        ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s
        ym = Time.now.strftime("%y%m").to_s
        @ref_no = ym + ref_temp_no
       if params[:enquiry_id]
                    # e stands for enquiry
                  e_obj = Enquiry.find(params[:enquiry_id])
                  # deactivate the enquiry as it is going to be registered
                  e_obj.update_attributes(active: false, audit_comment: params[:note].to_s)
                  
                  
                  Timeline.create!(user_id: current_user.id,
                                   user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                                   m_name: "Enquiry",
                                   m_id: params[:enquiry_id],
                                   created_at: Time.now,
                                   desc: 'This enquiry has been deactivated in order to register',
                                   comment: params[:note],
                                   action: 'registration')
                                   
                                   
                  e = e_obj.attributes.except("id","score","source_id",
                                              "created_at","updated_at",
                                              "status_id", "address","active","contact_type_id")
                  e[:note] = params[:note]
                  
                  @registration = Registration.new(e)
                  
                  if !e_obj.programmes.blank?
                    @registration.programmes << e_obj.programmes
                  end
                  
                  @countries = self.basic_select(Country)
                  @p_types = ProgrammeType.all
      else
                  @registration = Registration.new
                  @countries = self.basic_select(Country)
                  @p_types = ProgrammeType.all
      end
    elsif @status == "launch"
      @registration = Registration.find(@registration_id)
      @timelines = Timeline.where(m_name: "Registration", m_id: params[:registration_id]).order("created_at DESC")
    elsif @status == "edit"
      @registration = Registration.find(params[:registration_id])
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
    elsif @status == "clone"
      @registration = Registration.find(params[:registration_id]).dup
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
    else
      @cols = UserConfig.find(current_user).reg_cols
    end
    

    render partial: @partial

  end
  
    
  def action_partial
    set_url_params
    @registration = Registration.find(@registration_id)
    
    if @partial_name == "follow_up"
          @d_f_u_days = UserConfig.find_by_user_id(current_user.id).def_follow_up_days
          @follow_up = FollowUp.new(title: "First Follow Up", 
                                    desc: "This enquiry does not have an update, yet!.
                                           Should call this enquiry in 2 days.")

    elsif @partial_name == "note"
          @d_note = UserConfig.find_by_user_id(current_user.id).def_note
          @note = Note.new(content: @d_note)
          
    elsif @partial_name == "todo"
          @todo = Todo.new
    end
    
    if @partial_name == "email"
      mail_to_use = UserConfig.find(current_user.id).def_reg_email.to_sym
      
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
    
    ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s
    ym = Time.now.strftime("%y%m").to_s
    @ref_no = ym + ref_temp_no
    
    if !params[:enquiry_id].nil?
      # e stands for enquiry
      e_obj = Enquiry.find(params[:enquiry_id])
      # deactivate the enquiry as it is going to be registered
      e_obj.update_attributes(active: false, audit_comment: params[:note].to_s)
      
      
      Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: "Enquiry",
                       m_id: params[:enquiry_id],
                       created_at: Time.now,
                       desc: 'This enquiry has been deactivated in order to register',
                       comment: params[:note],
                       action: 'registration')
                       
                       
      e = e_obj.attributes.except("id","score","source_id",
                                  "created_at","updated_at",
                                  "status_id", "address","active","contact_type_id")
      e[:note] = params[:note]
      
      @registration = Registration.new(e)
      
      if !e_obj.programmes.blank?
        @registration.programmes << e_obj.programmes
      end
    else
      @registration = Registration.new(reg_direct: true)
    end 

    @registration.proficiency_exams.build
    @c_levels = self.basic_select(CourseLevel)
    @p_types = ProgrammeType.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end
  
  def clone
    @registration = Registration.find(params[:id])
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
    @countries = self.basic_select(Country)
    @p_types = ProgrammeType.all

    
    ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
    
    ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s
    ym = Time.now.strftime("%y%m").to_s
    @ref_no = ym + ref_temp_no
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      if @registration.save
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
    
    if (params[:registration][:assign].to_s == "from_action")
    
      ass_to = User.find(params[:registration][:assigned_to]).first_name
      ass_by = User.find(params[:registration][:assigned_by]).first_name
    
      Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: "Registration",
                       m_id: params[:id],
                       created_at: Time.now,
                       desc: 'This registration has been reassigned',
                       comment: 'Assigned To: ' + ass_to + ' | Assigned By: ' + ass_by,
                       action: 'assign_to')
    end

    respond_to do |format|
      if @registration.update_attributes(params[:registration].except("assign"))
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
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
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end
end
