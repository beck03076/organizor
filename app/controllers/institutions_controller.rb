class InstitutionsController < ApplicationController
  
  def tab
    set_url_params
    
    if @status == "new_institution"
      self.h_new
    elsif @status == "launch"
      @institution = Institution.find(@institution_id)
      @timelines = Timeline.where(m_name: "Institution", 
                                  m_id: params[:institution_id]).order("created_at DESC")
    elsif @status == "edit"
      @institution = Institution.find(params[:institution_id])
    elsif @status == "clone"
      orig = Institution.find(params[:institution_id])
      @institution = orig.dup
      authorize! :create, @institution
    else
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.ins_cols
      b = [:id,:name,:email,:phone]
      @cols = ((b & a) + (a - b)) + [:follow_up_date] 
    end
    
    render partial: @partial

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
      @subject = Institution.where(id: @institution_id)
      @subject_ids = (@subject.map &:id).join(",")
      @email_to = ((@subject.map &:email) - ["",nil]).join(", ")
      render :partial => 'enquiries/email', :locals => {:e => Email.new(to: @email_to), 
                                                     :id => params[:e_id],
                                                     :obj => @subject,
                                                     :obj_ids => "institution_ids",
                                                     :obj_name => "institution" }

    else
      @institution = Institution.find(@institution_id)
      render :partial => "enquiries/" + @partial_name.to_s, :locals => {:e => Email.new,
                                                  :id => @institution_id,
                                                  :obj => @institution,
                                                  :obj_id => "institution_id",
                                                  :obj_name => "institution"}
    end
     
  end
  
  # h_new stands for help_new
  def h_new
    @institution = Institution.new(type_id: InstitutionType.first.id)
    authorize! :create, @institution
  end
  
  
  # GET /institutions
  # GET /institutions.json
  def index
    set_url_params
    
     p "***********************"
    p @sCols

    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => InstitutionsDatatable.new(view_context,eval(@sCols),@sFilter)}
    end
  end
  

  # GET /institutions/1
  # GET /institutions/1.json
  def show
    @institution = Institution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @institution }
    end
  end

  # GET /institutions/new
  # GET /institutions/new.json
  def new
    
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
end
