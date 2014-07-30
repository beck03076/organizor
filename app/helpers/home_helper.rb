module HomeHelper
	def resource_name
		@resource_name ||= :user    
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def controller_name
  	@controller_name
  end

end
