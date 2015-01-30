class ReportsController < ApplicationController
  def index
  end

  def show
  	set_url_params
    self.repair_module    
  
  	r = Report.new(@module,@heading) 
    @cols = r.get_fil_hash    
  	@search = self.model.search(@q)
  	@results = @search.result(distinct: true).paginate(page: @page, per_page: @per_page)    
    @search.build_sort if @search.sorts.empty?  
    @saved_report = params[:saved_report] || SavedReport.new   

  end 

  def charts
    set_url_params
    self.repair_module
    self.set_pre
    @heading = "charts"    
    r = Report.new(@module,@heading,@asso)
    @cols = r.get_fil_hash    
    @main_sel = r.get_main_sel
    self.set_pie(r)
    self.set_bar(r) 
  end


  def set_pre
    @from ||= nil
    @to ||= nil
    @last_months ||= nil
  end

  def repair_module
    if @module == "single_user"
      @module = "users"      
    elsif @module == "partners"
      @asso = "partner_type"
    elsif @module == "people"
      @asso = "person_type"
    else
      @asso = "branch"
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
    set_url_params
    r = Report.new(@model,nil,@asso,nil,@from,@to,@last_months)    
    set_pie(r)
  end

  def partial_bar
    set_url_params
    r = Report.new(@model,nil,@asso,@sub_asso,@from_bar,@to_bar,@last_months_bar)      
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
