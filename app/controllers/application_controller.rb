 class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :set_current_user
  protect_from_forgery
  
  layout :layout

  rescue_from CanCan::AccessDenied do |e|
    p "888888888888888888888"
    p "unauthorized #{e.subject} and #{e.action}"
    flash[:notice] = "You are not authorized to #{e.action.to_s.downcase} any #{e.subject.class.model_name.to_s.downcase rescue "resource"}"
    redirect_to root_path
  end
  
  def group_assign
    set_url_params
    @model.camelize.constantize.where(id: params[:model_ids].split(",")).update_all(assigned_to: params[:user_id],
                                                                   assigned_by: current_user.id)
                                                                   
    render text: "Successfully assigned!"
  
  end
  
  def group_delete
    set_url_params
    @model.camelize.constantize.where(id: params[:model_ids].split(",")).delete_all
    render text: "Successfully assigned!"  
  end
  
  private
  
  def set_current_user
      User.current = current_user
  end

  def layout
    # only turn it off for login pages and user invite accept pages
    if is_a?(Devise::SessionsController) 
      false 
    elsif is_a?(Devise::PasswordsController) 
      false
    elsif is_a?(Users::InvitationsController) 
      false 
    else
      "application"
    end  
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
  
  def tl(model,p_id,msg,comment,act)
  
   Timeline.create!(user_id: current_user.id,
                    user_name: current_user.name,
                    m_name: model,
                    m_id: params[p_id],
                    created_at: Time.now,
                    desc: msg,
                    comment: comment,
                    action: act)
                    
  end
  
  
  
end
