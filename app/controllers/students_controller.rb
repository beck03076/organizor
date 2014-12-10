class StudentsController < ApplicationController
	include ActionsMethods

	skip_before_filter :authenticate_user!
	before_filter :authenticate_registration!
	alias_method :current_user,:current_registration
	
	helper_method :r_order,:meta
	
	layout false

  def index
  	@registration = current_registration
  	@partial = "students/basic"
  end
end
