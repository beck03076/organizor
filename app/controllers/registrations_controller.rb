class RegistrationsController < ApplicationController
  include CoreController
  include FetchFromContract
  include ActionsMethods
  helper_method :r_order,:meta
  skip_before_filter :authenticate_user!, only: [:action_partial,:show,:update]

  def tab
    set_url_params
    self.set_cols

    render partial: @partial
  end  
    
  def action_partial
    set_url_params
    #called from CoreMethods
    h_action_partial("registration",
                     params[:registration_id],
                     ["application","document","finance","permission","comment"])
     
  end
  
  # GET /registrations
  # GET /registrations.json
  def index
   authorize! :list, Registration 
   set_url_params
   self.set_cols

    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("registration") } # in core_methods
      format.js { core_js("registration") } # in core_methods
      format.select { render json: Registration.all }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])
    #authorize! :read, @registration
    # showing basic by default
    @partial = "basic"
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    # special because when it is registered from enquiry the new form has to carry over enquiry values
    self.h_new
        
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
      if params[:enquiry_id]
                  # e stands for enquiry
                  e_obj = Enquiry.find(params[:enquiry_id])                                
                  e = e_obj.attributes.except("id","score","source_id",
                                              "created_at","updated_at",
                                              "status_id", "address",
                                              "active","contact_type_id",
                                              "registered","registered_at",
                                              "registered_by","conversion_time")
                  e[:enquiry_id] = params[:enquiry_id] 
                  @enquiry_id = params[:enquiry_id]
                  @registration = Registration.new(e)
                  authorize! :create, @registration
                  
                  if !e_obj.programmes.blank?
                    @registration.programmes << e_obj.programmes
                  end
                  if params[:note]
                    @registration.notes << Note.new(content: params[:note])
                  end
      else
                  @registration = Registration.new(assigned_to: current_user.id,
                                                   date_of_birth: (Date.today - 21.years),
                                                   gender: "m")
                  authorize! :create, @registration
      end
      
      @countries = basic_select(Country)
      @p_types = InstitutionType.where(educational: true)
  end
  
  def set_cols
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.reg_cols
      b = [:id,:ref_no,:first_name,:surname,:mobile1,:email,:gender,:date_of_birth]
      @cols = ((b & a) + (a - b)) + [:follow_up_date]
  end
  
end
