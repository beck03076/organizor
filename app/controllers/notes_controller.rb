class NotesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper  
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note].except("note"))
    
                           
    if (params[:note][:note].to_s == "from_action")
   
      Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: params[:note][:sub_class],
                       m_id: params[:note][:sub_id],
                       created_at: Time.now,
                       desc: strip_tags(params[:note][:content].to_s),
                       comment: "Note by " + current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       action: 'note')
                       
    end

    respond_to do |format|
      if @note.save
        format.html { redirect_to "/#{params[:note][:sub_class].pluralize.downcase}/" + params[:note][:sub_id].to_s }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
    
    
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end
end
