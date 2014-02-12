class PeopleController < ApplicationController
  include CoreMethods

   def tab
    set_url_params
    
    if @status == "new_person"
      self.h_new
    elsif @status == "launch"
      @person = Person.find(@person_id)
      @timelines = Timeline.where(m_name: "Person", 
                                  m_id: params[:person_id]).order("created_at DESC")
    elsif @status == "edit"
      @person = Person.find(params[:person_id])
    elsif @status == "clone"
      orig = Person.find(params[:person_id])
      @person = orig.dup
      authorize! :create, @person
    else
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.per_cols
      b = [:id,:first_name,:surname,:email,:mobile]
      @cols = ((b & a) + (a - b)) + [:follow_up_date] 
    end
    
    render partial: @partial

  end
  
  # h_new stands for help_new
  def h_new
    @person = Person.new(type_id: PersonType.first.id)
    authorize! :create, @person
  end
  
  # GET /people
  # GET /people.json
  def index
    set_url_params

    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("person") } # in core_methods
      format.js { core_js("person") } # in core_methods
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        if (params[:person][:notes_attributes])
          
                tl("Person",@person.id,'A note to a person has been created.',
             "#{(@person.name rescue "Unknown")}",'Note',@person.assigned_to)
            
        end
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    authorize! :destroy, @person
    
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
end
