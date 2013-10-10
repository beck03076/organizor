class EnquiriesController < ApplicationController


  def programme
    @co = params[:co]
    @ci = params[:ci]
    p_type = ProgrammeType.where(:name => params[:type]).map &:id
    self.pre(p_type,params[:co],params[:ci])
    render :partial => params[:type], :locals => { :p => Programme.new }
  end
  
  def group_assign_to
  
  end
  
  def tab
    set_url_params
    
    if @status == "new_enquiry"
      @enquiry = Enquiry.new
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
      @enquiry.programmes.build
    elsif @status == "launch"
      @enquiry = Enquiry.find(params[:enquiry_id])
      @timelines = Timeline.where(m_name: "Enquiry", m_id: params[:enquiry_id]).order("created_at DESC")
    elsif @status == "edit"
      @enquiry = Enquiry.find(params[:enquiry_id])
      @countries = self.basic_select(Country)
      @p_types = ProgrammeType.all
      @enquiry.programmes.build
    else
      @cols = UserConfig.find(current_user).enq_cols
    end
    
    render :partial => @partial
  end
  
  def action_partial
    set_url_params
    @enquiry = Enquiry.find(@enquiry_id)
    
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
   
    render :partial => @partial_name, :locals => {:e => Email.new,
                                                  :id => @enquiry_id,
                                                  :obj => @enquiry,
                                                  :obj_id => "enquiry_id",
                                                  :obj_name => "enquiry"}
     
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
    @timelines = Timeline.where(m_name: "Enquiry", m_id: params[:id]).order("created_at DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render partial: 'show'}
    end
  end

  # GET /enquiries/new
  # GET /enquiries/new.json
  def new
    @enquiry = Enquiry.new
#    self.pre
    @countries = self.basic_select(Country)
@p_types = ProgrammeType.all
    @enquiry.programmes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @enquiry }
    end
  end

  # GET /enquiries/1/edit
  def edit
    @enquiry = Enquiry.find(params[:id])
  end

  # POST /enquiries
  # POST /enquiries.json
  def create
    @enquiry = Enquiry.new(params[:enquiry])

    respond_to do |format|
      if @enquiry.save
        format.html { redirect_to @enquiry, notice: 'Enquiry was successfully created.' }
        format.json { render json: @enquiry, status: :created, location: @enquiry }
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
    
    if (params[:enquiry][:assign].to_s == "from_action")
    
      ass_to = User.find(params[:enquiry][:assigned_to]).first_name
      ass_by = User.find(params[:enquiry][:assigned_by]).first_name
    
      Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: "Enquiry",
                       m_id: params[:id],
                       created_at: Time.now,
                       desc: 'This enquiry has been reassigned',
                       comment: 'Assigned To: ' + ass_to + ' | Assigned By: ' + ass_by,
                       action: 'assign_to')
                       
    elsif (params[:enquiry][:deactivate].to_s == "from_action")
   
      Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: "Enquiry",
                       m_id: params[:id],
                       created_at: Time.now,
                       desc: 'This enquiry has been deactivated',
                       comment: "Deactivated",
                       action: 'deactivate')

    
    end

    respond_to do |format|
      if @enquiry.update_attributes(params[:enquiry].except("assign","deactivate"))
        format.html { redirect_to @enquiry, notice: 'Enquiry was successfully updated.' }
        format.json { head :no_content }
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
    @enquiry.destroy

    respond_to do |format|
      format.html { redirect_to enquiries_url }
      format.json { head :no_content }
    end
  end
  
  def pre(p_type = 1,co = nil,ci = nil)
    @countries = self.basic_select(Country)
    if !co.nil? && !ci.nil?      
      country = Country.find(co)
      @cities = self.basic_select(country.cities)
      city = City.find(ci)
      @institutions = self.basic_select(city.institutions,{:type_id => p_type})
    elsif !co.nil?     
      country = Country.find(co)
      @cities = self.basic_select(country.cities)
      @institutions = []
    elsif co.nil?       
      @cities = []
      @institutions = []
    end  
    @p_types = ProgrammeType.all
    @c_levels = self.basic_select(CourseLevel)
  end
  
  def basic_select(model,cond = true)
    model.where(cond).order(:name).map{|i| [i.name,i.id]}
  end
  
end
