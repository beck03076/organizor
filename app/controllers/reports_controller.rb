class ReportsController < ApplicationController
  def index
  end

  def show
  	set_url_params
    self.repair_module
    r = Report.new(@module,@heading)
  	@cols = r.get_fil_hash    
  	@search = self.model.search(@q)
  	@results = @search.result.paginate(page: @page, per_page: 3)    
    @search.build_sort if @search.sorts.empty?
    @main_sel = r.get_main_sel
    self.set_pie(r)
    self.set_bar(r)   
    @saved_report = params[:saved_report] || SavedReport.new
  end 

  def repair_module
    if @module == "single_user"
      @module = "users"
    end
  end

  def set_pie(obj)
    @pie = obj.get_current_pie    
    @pie_meta = "#{obj.mod.titleize} based on #{obj.asso.titleize}"
  end

  def set_bar(obj)
    @bar = obj.get_current_bar    
    @bar_meta = "#{obj.mod.titleize} based on #{obj.asso.titleize}"   
    @bar_split = obj.get_bar_split_sel  
  end

  def model 
    @module.singularize.camelize.constantize
  end

  def partial_pie
    r = Report.new(params[:model],nil,params[:asso],nil,params[:year],params[:month])    
    set_pie(r)
  end

  def partial_bar
    r = Report.new(params[:model],nil,params[:asso],params[:sub_asso],params[:year],params[:month])    
    set_bar(r)    
  end

  def save_report    
    @saved_report = SavedReport.find_or_initialize_by_q_and_created_by_and_heading_and_module(params[:q].to_s,current_user.id,params[:heading],params[:module])  
  end


  def single_user

  end

  def compare_users

  end

  def user_performance
  end

  def course_level

  end

  def application_status

  end

  def student_source

  end



end
