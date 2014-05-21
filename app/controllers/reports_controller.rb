class ReportsController < ApplicationController
  def index
  end

  def show
  	set_url_params
    r = Report.new(@module,@heading)
  	@cols = r.get_fil_hash
  	@search = self.model.search(params[:q])
  	@results = @search.result.paginate(page: @page, per_page: 5)    
    @search.build_sort if @search.sorts.empty?
    @main_sel = r.get_main_sel
    self.set_pie(r)
    self.set_bar(r) 
    @q = params[:q]   
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
    r = Report.new(params[:model],nil,params[:asso])    
    set_pie(r)
  end

  def partial_bar
    r = Report.new(params[:model],nil,params[:asso],params[:split])    
    set_bar(r)    
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
