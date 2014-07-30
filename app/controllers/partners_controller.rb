class PartnersController < ApplicationController
	include ActionsMethods
                                                    
	skip_before_filter :authenticate_user!
	before_filter :authenticate_institution!
	alias_method :current_user,:current_institution
	
	helper_method :r_order,:meta
	
	layout false

  def index
  	@institution = current_institution
  	@partial = "institutions/basic"  	
  end
end

