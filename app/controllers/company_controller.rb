class CompanyController < ApplicationController
	include ActionsMethods

	skip_before_filter :authenticate_user!
	before_filter :authenticate_partner!
	alias_method :current_user,:current_partner
	
	helper_method :r_order,:meta
	
	layout false

  def index
  	@partner = current_partner
  	@partial = "company/basic"
  end

end
