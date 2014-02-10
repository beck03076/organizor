class ProgrammesController < ApplicationController
authorize_resource
  # GET /programmes
  # GET /programmes.json
  def index
    @programmes = Programme.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programmes }
    end
  end

  # GET /programmes/1
  # GET /programmes/1.json
  def show
    @programme = Programme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @programme }
    end
  end

  # GET /programmes/new
  # GET /programmes/new.json
  def new
    @enquiry = Enquiry.find(params[:id])
    @enquiry.programmes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @programme }
    end
  end

  # GET /programmes/1/edit
  def edit
    @programme = Programme.find(params[:id])
  end

  # POST /programmes
  # POST /programmes.json
  def create
    @programme = Programme.new(params[:programme])

    respond_to do |format|
      if @programme.save
        format.html { redirect_to @programme, notice: 'Programme was successfully created.' }
        format.json { render json: @programme, status: :created, location: @programme }
      else
        format.html { render action: "new" }
        format.json { render json: @programme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programmes/1
  # PUT /programmes/1.json
  def update
    @programme = Programme.find(params[:id])
    
    # the following block decimals up the entered tuition_fee and scholarship
    if params[:programme][:fee_attributes].present?
        %w(tuition_fee scholarship).each do |s|
          self.set_fee_params(s)
        end
    end

    respond_to do |format|
      if @programme.update_attributes(params[:programme])
        if (params[:programme][:notes_attributes])
          
          tl("Registration",@programme.registration.id,'A note to a programme has been created for this registration',
             "#{(@programme.institution.name rescue "Unknown")}",'Note',@programme.registration.assigned_to)
            
        end
      
        format.html { redirect_to @programme.registration, notice: 'Programme was successfully updated.' }
        format.json { head :no_content }
        
        if params[:change_status].nil?
          format.js { render "programmes/update" }
        else
        
          StatusDiagram.create!(user_id: current_user.id,
                                status_id: params[:programme][:app_status_id],
                                programme_id: params[:id])
          tl("Registration",
             @programme.registration.id,
             'Status of an application has been changed for this registration',
             "#{(@programme.institution.name rescue "Unknown")}",
             'StatusChange',
             @programme.registration.assigned_to)
             
          format.js { render "application_statuses/update" } 
          
        end   
      else
        format.html { render action: "edit" }
        format.json { render json: @programme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programmes/1
  # DELETE /programmes/1.json
  def destroy
    @programme = Programme.find(params[:id])
    @programme.destroy

    respond_to do |format|
      format.html { redirect_to @programme.registration }
      format.json { head :no_content }
    end
  end
  
  def set_fee_params(s)
    ss = s.to_sym
    params[:programme][:fee_attributes][(s + '_cents').to_sym] = params[:programme][:fee_attributes][ss].tr(',','').to_f * 100
    params[:programme][:fee_attributes].delete(ss)
  end

end
