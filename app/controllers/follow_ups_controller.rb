class FollowUpsController < ApplicationController

  def show_hover 
    @follow_up = FollowUp.find(params[:id])
    render partial: "follow_ups/show_hover" 
  end
  # GET /follow_ups
  # GET /follow_ups.json
  def index  
    set_url_params
    @follow_ups = FollowUp.where(assigned_to: current_user.id).reject{|i| i.starts_at.nil? }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @follow_ups }
    end
  end

  # GET /follow_ups/1
  # GET /follow_ups/1.json
  def show
    @follow_up = FollowUp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @follow_up }
    end
  end

  # GET /follow_ups/new
  # GET /follow_ups/new.json
  def new
    @follow_up = FollowUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @follow_up }
    end
  end

  # GET /follow_ups/1/edit
  def edit
    @follow_up = FollowUp.find(params[:id])
  end

  # POST /follow_ups
  # POST /follow_ups.json
  def create
  
    m = params[:follow_up][:model]
    m_id = (m + "_id").to_sym
    params[:follow_up].delete(:model)
  
    @follow_up = FollowUp.new(params[:follow_up])
    
    ass_to = User.find(params[:follow_up][:assigned_to]).first_name
                       
     tl(m.capitalize,params[:follow_up][m_id],
        "A follow up has been created for this #{m}",
         params[:follow_up][:title].to_s + ' at ' + params[:follow_up][:starts_at] + ' | assigned(follow up) to: ' + ass_to,
         'follow_up',
         params[:follow_up][:assigned_to])

    respond_to do |format|
      if @follow_up.save
        format.html { redirect_to "/#{m.pluralize}/" + params[:follow_up][m_id].to_s }
        format.json { render json: @follow_up, status: :created, location: @follow_up }
      else
        format.html { render action: "new" }
        format.json { render json: @follow_up.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PUT /follow_ups/1
  # PUT /follow_ups/1.json
  def update
    @follow_up = FollowUp.find(params[:id])

    respond_to do |format|
      if @follow_up.update_attributes(params[:follow_up])
        format.html { redirect_to @follow_up, notice: 'Follow up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @follow_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follow_ups/1
  # DELETE /follow_ups/1.json
  def destroy
    @follow_up = FollowUp.find(params[:id])
    @follow_up.destroy

    respond_to do |format|
      format.html { redirect_to follow_ups_url }
      format.json { head :no_content }
    end
  end
end
