class UserConfigsController < ApplicationController
  before_filter :set_cols
  
  def set_cols
    @def_reg_cols = {:country_id => [:country,:name],
     :qua_id => [:qualification,:name],
     :reg_source_id => [:student_source,:name],
     :sub_agent_id => [:sub_agent,:name],
     :assigned_to => [:_assigned_to,:first_name],
     :assigned_by => [:_assigned_by,:first_name],
     :created_by => [:_created_by,:first_name],
     :updated_by => [:_updated_by,:first_name],
     :prof_eng_level_id => [:english_level,:name]}
     
    @def_enq_cols = {:country_id => [:country_of_origin,:name],
     :source_id => [:student_source,:name],
     :contact_type_id => [:contact_type,:name],
     :sub_agent_id => [:sub_agent,:name],
     :assigned_to => [:_assigned_to,:first_name],
     :assigned_by => [:_assigned_by,:first_name],
     :created_by => [:_created_by,:first_name],
     :updated_by => [:_updated_by,:first_name],
     :status_id => [:status,:name]}
  end
  
  # GET /user_configs
  # GET /user_configs.json
  def index
    @user_config = current_user.conf

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_configs }
    end
  end

  # GET /user_configs/1
  # GET /user_configs/1.json
  def show
    @user_config = UserConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_config }
    end
  end

  # GET /user_configs/new
  # GET /user_configs/new.json
  def new
    @user_config = UserConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_config }
    end
  end

  # GET /user_configs/1/edit
  def edit
    @user_config = current_user.conf
  end

  # POST /user_configs
  # POST /user_configs.json
  def create
    @user_config = UserConfig.new(params[:user_config])

    respond_to do |format|
      if @user_config.save
        format.html { redirect_to @user_config, notice: 'User config was successfully created.' }
        format.json { render json: @user_config, status: :created, location: @user_config }
      else
        format.html { render action: "new" }
        format.json { render json: @user_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_configs/1
  # PUT /user_configs/1.json
  def update
    @user_config = UserConfig.find(params[:id])
    
    %w(reg enq).each do |i|
      var = i + "_cols"
      inst = eval("@def_" + i + "_cols")
      par = params[:user_config][var.to_sym]
      
      if !par.nil?
          sym_cols = par.map &:to_sym
          params[:user_config][var.to_sym] = self.prepare_cols(sym_cols,inst)
      end
    end

    respond_to do |format|
      if @user_config.update_attributes(params[:user_config])
        format.html { redirect_to root_path, notice: 'User config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_config.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /user_configs/1
  # DELETE /user_configs/1.json
  def destroy
    @user_config = UserConfig.find(params[:id])
    @user_config.destroy

    respond_to do |format|
      format.html { redirect_to user_configs_url }
      format.json { head :no_content }
    end
  end
  
  def prepare_cols(c,default)
    c.map{|i| 
    if default[i].nil? 
      i 
    else
      if default[i].is_a?(Array)
        default[i].unshift(i)
      else
        default[i]
      end
    end
    }
  end
end
