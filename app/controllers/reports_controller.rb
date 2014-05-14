class ReportsController < ApplicationController
  def index
  end

  def show
  	set_url_params
    r = Report.new(@module,@heading)
  	@cols = r.get_fil_hash
  	@search = self.model.search(params[:q])
  	@results = @search.result
    @search.build_sort if @search.sorts.empty?
    self.set_pie(r)    
  end 

  def set_pie(obj)
    @pie = obj.get_current_pie
    @pie_value = obj.get_pie_sel
    @pie_meta = "#{@module.titleize} based on #{obj.asso.titleize}"
  end

  def model
    @module.singularize.camelize.constantize
  end

  def enquiries
    
  end

  def registrations

  end

  def institutions

  end

  def people
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
