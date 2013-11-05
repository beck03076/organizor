 class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :set_current_user
  protect_from_forgery
  
  layout :layout

  rescue_from CanCan::AccessDenied do |e|
    p "***********************"
    p "unauthorized subject: #{e.subject} and action: #{e.action}"
    p "***********************"
    
    flash[:notice] = "You are not authorized to #{e.action.to_s.downcase} any #{e.subject.class.model_name.to_s.downcase rescue "resource"}"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render :js => "info('Unauthorized','#{flash[:notice]}');" }
    end
  end
  
  def group_assign
    set_url_params
    model = @model.camelize.constantize
    authorize! :update, model
    
    ids = params[:model_ids].split(",")
    
    to_update = model.where(id: ids)
    to_update.update_all(assigned_to: params[:user_id],
                         assigned_by: current_user.id)
                         

    ass_to = User.find(params[:user_id]).first_name
    ass_by = User.find(current_user.id).first_name
    
    tl(@model.camelize,0,"#{ids.size} #{@model.camelize.pluralize} has been reassigned",
         'Assigned To: ' + ass_to + ' | Assigned By: ' + ass_by,
         'assign_to',params[:user_id])
    
    model.find(ids.first).update_attribute(:updated_at,Time.now)
                          
    render text: "Successfully assigned!"
  
  end
  
  def group_delete
    set_url_params
    model = @model.camelize.constantize
    authorize! :destroy, model
    
    to_delete = model.where(id: params[:model_ids].split(","))
    to_delete.delete_all
    
    render text: "Successfully assigned!"  
  end
  
  def notify
    @tl = Timeline.where(receiver_id: params[:id]).order("created_at desc").first
    @notify_count = Timeline.where(receiver_id: params[:id],checked: false).count
    
    render :partial => "shared/notifications", :locals => {:tl => @tl,:count => @notify_count}
    
  end
  
  def mark_all_check
    Timeline.where(receiver_id: params[:id]).update_all(checked: true)
    render text: "Successfully marked!"  
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
  
  def tl(model,p_id,msg,comment,act,r_id = nil)
  
   Timeline.create!(user_id: current_user.id,
                    user_name: current_user.name,
                    m_name: model,
                    m_id: p_id,
                    created_at: Time.now,
                    desc: msg,
                    comment: comment,
                    action: act,
                    checked: false,
                    receiver_id: r_id)
                    
  end
  
  
  
  
end
