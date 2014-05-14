require "ipaddr"

class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :set_current_user, :ban_ip, except: [:ban_ip]
  protect_from_forgery
  
  
  layout :layout

  rescue_from CanCan::AccessDenied do |e|
    p "***********************"
    p "unauthorized subject: #{e.subject} and action: #{e.action}"
    p "***********************"
    
    flash[:notice] = "You are not authorized to #{e.action.to_s.downcase} this #{e.subject.class.model_name.to_s.downcase rescue "resource"}"
    respond_to do |format|
      format.html { redirect_to '/handle/cancan'  }
      format.js { redirect_to '/handle/cancan' }
#      render :js => "info('Unauthorized','#{flash[:notice]}');" }
    end
  end

  def five_notifications
     @notys = Audit.notys(current_user.id)
     #Audit.set_all_checked(current_user.id)
     render partial: 'shared/notifications'
  end

  def unchecked_notys
    cnt = Audit.unchecked(current_user.id).size
    render text: cnt
  end 
    
  def token_search
    set_url_params
    @result = @model.camelize.constantize.where("#{@col} like ?", "%#{params[:q]}%")
      respond_to do |format|
        format.html
        format.json { render :json => @result.map(&:attributes) }
      end
  end
  
  def get_column_names
    set_url_params
    out = @model.camelize.constantize.column_names.grep(/^#{@filter}\d*$/)
    render json: out
  end
  
  def bulk_asso_update
    set_url_params
    
    @model = @main.camelize.constantize
    authorize! :update, @model
    
    ids = @main_ids.split(",")
    to_update = @model.where(id: ids)
    
    @status = @asso.camelize.constantize.find(@asso_id).name
    
    to_update.each do |u|
      u.update_attributes(@asso_col.to_sym => @asso_id,
                          updated_by: @user_id)
    end
                         
    text = "#{@status} set."
    
    render text: text
  end
  
  
  def determine_redirect
   p "==== determining redirect====="
   #What data comes back from OmniAuth?     
   @auth = request.env["omniauth.auth"]
   #Use the token from the data to request a list of calendars
   session[:token] = @auth["credentials"]["token"]
      
    redirect_to session[:destination]
  end
  
  def validate_recruit
    set_url_params
 
    contract = Institution.find(@ins_id).contracts.first
    if @form_country_id.to_i == 0
      @co_id = @model.camelize.constantize.find(@item_id).country_id
    else
      @co_id = @form_country_id.to_i
    end
    
    if contract.nil? 
      @out = "No contract created for this institution, skipping recruitment territory validation!"
    elsif !@co_id.nil?
        pro_coun = contract.all_prohibited_countries.map &:id
        pro_reg = contract.all_prohibited_regions.map &:id
        per_coun = contract.all_permitted_countries.map &:id
        per_reg = contract.all_permitted_regions.map &:id
        
        if pro_coun.blank? && pro_reg.blank? && per_coun.blank? && per_reg.blank?
          @out = "No regions/countries are prohibited/permitted in the contract, skipping recruitment territory validation!"
        else
            pro_regions_coun = Country.includes(:region).where(region_id: pro_reg).map &:id
            pro = pro_coun + pro_regions_coun
            
            per_regions_coun = Country.includes(:region).where(region_id: per_reg).map &:id
            per = per_coun + per_regions_coun
            
            if pro.include?(@co_id.to_i)
              @out = "This students country of origin is a prohibited territory as per this institutions contract"
            else    
              @out = "Not a prohibited territory!"
            end
            
            if !per.empty? && per.include?(@co_id.to_i)
              @out = "Permitted territory!"
            else
              @out = "This students country of origin is not a permitted territory as per this institutions contract"
            end
        end
    end

    render text: @out
  
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
    if (@model == "Enquiry")
      to_delete = model.where(id: params[:model_ids].split(","))
      deact = EnquiryStatus.find_by_name("deactivated").id
      to_delete.update_all(active: false,
                           status_id: deact)
         to_delete.each do |e|
         #create a timeline item
         tl("Enquiry",e.id,
            'This enquiry has been deactivated as a group','Deactivated',
             "Deactivate",e.assigned_to)
         end
    else
      to_delete = model.where(id: params[:model_ids].split(","))
      to_delete.delete_all
    end
    
    render text: "Successfully deactivated!"  
  end
  
  def export_details
    set_url_params
    
    respond_to do |format|
        format.xls {xls_pdf
        render "#{@model.to_s.downcase.pluralize}/index.xls.erb"}
    end
  end
  
  def xls_pdf 
    @records = @model.camelize.constantize.where(id: @ids.split(","))
    @filename = "#{Time.now.to_i}_#{@records.size}_#{@model.to_s.downcase.pluralize}.#{@format}"
    headers["Content-Disposition"] = "attachment; filename=\"#{@filename}\"" 
  end
  
  def notify
    @tl = Timeline.find(params[:t_id])
    @notify_count = Timeline.where(receiver_id: params[:receiver_id],checked: false).count
    
    render :partial => "shared/notifications", :locals => {:tl => @tl,:count => @notify_count,u: @tl.user}
    
  end
  
  def mark_all_check
    Timeline.where(receiver_id: params[:id]).update_all(checked: true)
    render text: "Successfully marked!"  
  end
  
  def all_notifications
    @tls = Timeline.includes(:user).where(receiver_id: current_user.id).order("created_at desc")
    render 'shared/all_notifications'
  end
  
  private
  
  def set_current_user
      User.current = current_user
  end
  
  def ban_ip
    if (    !current_user.adm? rescue nil)
        result = []
    
        AllowIp.all.each do |o|
          t = o.to
          f = o.from
          if (!t.nil? && !f.nil?)
            low = IPAddr.new(f).to_i
            high = IPAddr.new(t).to_i
            ip = IPAddr.new(request.remote_ip).to_i
            result << ((low..high)===ip)
          end
        end

        if !result.include?(true)
          redirect_to banned_path
        end
    end
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
