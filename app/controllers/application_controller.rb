class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :set_current_user
  protect_from_forgery
  
  layout :layout
  
  private
  
  def set_current_user
      User.current = current_user
  end

  def layout
    # only turn it off for login pages
    is_a?(Devise::SessionsController) ? false : "application"
  
  end
  
  def basic_select(model,cond = true)
    model.where(cond).order(:name).map{|i| [i.name,i.id]}
  end
  
  def set_url_params(params_list = 0)  
    if params_list == 0    
      params_list = params.keys.join(",")                            
    end
        
    params_list.split(",").each do |p|    
       if !params[p.to_sym].nil?            
         val = params[p.to_sym]               
         instance_variable_set("@"+p,val)                            
      end                  
    end    
  end
end
