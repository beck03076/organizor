class EnquiriesController < ApplicationController

  def error
    render 'shared/error'
  end
  
  def programme
    @co = params[:co]
    @ci = params[:ci]
    p_type = ProgrammeType.where(:name => params[:type]).map &:id
    self.pre(p_type,params[:co],params[:ci])
    render :partial => params[:type], :locals => { :p => Programme.new }
  end
  # h_new stands fpr help_new
  def h_new
    @enquiry = Enquiry.new(assigned_to: current_user.id)
    authorize! :create, @enquiry
      
    @countries = self.basic_select(Country)
    @p_types = ProgrammeType.all
  end
  
  def tab
    set_url_params
    
    if @status == "new_enquiry"
      self.h_new
    elsif @status == "launch"
      @enquiry = Enquiry.find(params[:enquiry_id])
      if @enquiry.active == false
        authorize! :manage, :all
      end
      @timelines = Timeline.where(m_name: "Enquiry", m_id: params[:enquiry_id]).order("created_at DESC")
    elsif @status == "edit"
      @enquiry = Enquiry.find(params[:enquiry_id])
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
    elsif @status == "clone"
      orig = Enquiry.find(params[:enquiry_id])
      @enquiry = orig.dup :include => [:programmes, :countries]
      authorize! :create, @enquiry
      
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
    else
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.enq_cols
      b = [:id,:first_name,:surname,:mobile1,:email1,:gender,:date_of_birth]
      @cols = ((b & a) + (a - b)) + [:follow_up_date] 
    end
    
    render :partial => @partial
  end
  
  def action_partial
    set_url_params

    if @partial_name == "follow_up"
          
          #@d_f_u_days = current_user.conf.def_follow_up_days
          con = current_user.conf
          @follow_up = FollowUp.new(title: con.def_f_u_name, 
                                    desc: con.def_f_u_desc)

    elsif @partial_name == "note"
          @d_note = current_user.conf.def_note
          @note = Note.new(content: @d_note)
          
    elsif @partial_name == "todo"
          @todo = Todo.new
    end
    # next if block becase of separate renders
    if @partial_name == "email"
      mail_to_use = current_user.conf.def_enq_email.to_sym
      
      @subject = Enquiry.where(id: @enquiry_id)
      @subject_ids = (@subject.map &:id).join(",")
      @email_to = ((@subject.map &mail_to_use) - ["",nil]).join(", ")
      render :partial => 'enquiries/email', :locals => {:e => Email.new(to: @email_to), 
                                                     :id => params[:e_id],
                                                     :obj => @subject,
                                                     :obj_ids => "enquiry_ids",
                                                     :obj_name => "enquiry" }

    else
      @enquiry = Enquiry.find(@enquiry_id)
      render :partial => @partial_name, :locals => {:e => Email.new,
                                                  :id => @enquiry_id,
                                                  :obj => @enquiry,
                                                  :obj_id => "enquiry_id",
                                                  :obj_name => "enquiry"}
    end
     
  end
  
  # GET /enquiries
  # GET /enquiries.json
  def index
    set_url_params

    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => EnquiriesDatatable.new(view_context,eval(@sCols),@sFilter)}
    end
  end

  # GET /enquiries/1
  # GET /enquiries/1.json
  def show
    @enquiry = Enquiry.find(params[:id])
    authorize! :read, @enquiry
    
    @timelines = Timeline.where(m_name: "Enquiry", m_id: params[:id]).order("created_at DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render partial: 'show'}
    end
  end

  # GET /enquiries/new
  # GET /enquiries/new.json
  def new
    
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
    
    @enquiry.destroy

    respond_to do |format|
      format.html { redirect_to enquiries_path, notice: 'Enquiry was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  def basic_select(model,cond = true)
    model.where(cond).order(:name).map{|i| [i.name,i.id]}
  end
  
end
