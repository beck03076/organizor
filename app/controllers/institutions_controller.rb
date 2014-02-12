class InstitutionsController < ApplicationController
  include CoreMethods
  
  def tab
    set_url_params
    self.set_cols      
    render partial: @partial
  end
  
  def action_partial
    set_url_params
    
    if @partial_name == "finance"
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.pro_cols
      b = [:start_date]
      @cols = ((b & a) + (a - b))
    end
    
    #called from CoreMethods
    h_action_partial("institution",
                     params[:institution_id],
                     ["contract","people","finance"])
     
  end
  
  # h_new stands for help_new
  def h_new
    
  end
  
  
  # GET /institutions
  # GET /institutions.json
  def index
    set_url_params

    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("institution") } # in core_methods
      format.js { core_js("institution") } # in core_methods
    end
  end
  

  # GET /institutions/1
  # GET /institutions/1.json
  def show
    @institution = Institution.find(params[:id])
    authorize! :read, @institution
    # showing basic by default
    @partial = "basic"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @institution }
    end
  end

  # GET /institutions/new
  # GET /institutions/new.json
  def new
    @institution = Institution.new(type_id: InstitutionType.first.id)
    authorize! :create, @institution    
  end
  
  def clone
    # To have this next line, is to display the enquiry name on the tab, thats all
    @institution = Institution.find(params[:id])
    authorize! :create, @institution
  end

  # GET /institutions/1/edit
  def edit
    @institution = Institution.find(params[:id])
  end

  # POST /institutions
  # POST /institutions.json
  def create
    @institution = Institution.new(params[:institution])

    respond_to do |format|
      if @institution.save
        format.html { redirect_to @institution, notice: 'Institution was successfully created.' }
        format.json { render json: @institution, status: :created, location: @institution }
      else
        format.html { render action: "new" }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /institutions/1
  # PUT /institutions/1.json
  def update
    @institution = Institution.find(params[:id])
    authorize! :update, @institution

    respond_to do |format|
      if @institution.update_attributes(params[:institution].except("assign","_destroy"))
        if (params[:institution][:assign].to_s == "from_action")
    
          ass_to = User.find(params[:institution][:assigned_to]).first_name
          ass_by = User.find(params[:institution][:assigned_by]).first_name
          
          tl("Registration",params[:id],'This institution has been reassigned',
              'Assigned To: ' + ass_to + ' | Assigned By: ' + ass_by,'assign_to',params[:institution][:assigned_to])      
              
        elsif params[:institution][:notes_attributes]
          tl("Institution",params[:id],'A note has been created for this institution',
             "Note created",'note',@institution.assigned_to)
        else
          tl("Institution",params[:id],'Values of this institution has been updated',
             "Updated",'Update',@institution.assigned_to)
        end
        format.html { redirect_to @institution, notice: 'Institution was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /institutions/1
  # DELETE /institutions/1.json
  def destroy
    @institution = Institution.find(params[:id])
    authorize! :destroy, @institution
    @institution.destroy

    respond_to do |format|
      format.html { redirect_to institutions_url }
      format.json { head :no_content }
    end
  end
  
  def set_cols 
    # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.ins_cols
      b = [:id,:name,:email,:phone]
      @cols = ((b & a) + (a - b)) + [:follow_up_date]
  
  end
end
