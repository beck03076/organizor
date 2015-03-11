class HomeController < ApplicationController
  skip_before_filter :authenticate_user!,:authenticate_registration!,:authenticate_partner!
	layout false

  def index
  	if params[:type]
  		@type = params[:type]

  	  type_singular = @type.singularize
  	  type_model = type_singular.camelize.constantize

  	  @resource_name = type_singular.to_sym
  		@resource = type_model.new
  		@devise_mapping = Devise.mappings[@resource_name]
  		@controller_name = "sessions"
    end
  end

end
