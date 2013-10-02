class RegistrationsController < ApplicationController

  def basic_select(model,cond = true)
    model.where(cond).order(:name).map{|i| [i.name,i.id]}
  end
  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
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
                                  "status_id", "address","active")
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
    
    @city = 
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      if @registration.save
        format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
        format.json { render json: @registration, status: :created, location: @registration }
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

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
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
