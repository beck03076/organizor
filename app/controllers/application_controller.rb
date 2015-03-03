require "ipaddr"

class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :set_current_user #, :ban_ip, except: [:ban_ip]
  before_filter :set_last_seen_at, if: proc { |p| user_signed_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 15.minutes.ago) }
  protect_from_forgery

  layout :layout

  def current_user_with_registration
    current_user_without_registration || current_registration
  end
  alias_method_chain :current_user, :registration

 # def authenticate_user_with_registration!
 #  authenticate_user_without_registration! || authenticate_registration!
 # end
  #alias_method_chain :authenticate_user! , :registration

  rescue_from CanCan::AccessDenied do |e|

    flash[:notice] = "You are not authorized to #{e.action.to_s.downcase} this #{e.subject.class.model_name.to_s.downcase rescue "resource"}"
    respond_to do |format|
      format.html { redirect_to '/handle/cancan'  }
      format.js { redirect_to '/handle/cancan' }
    end
  end

  def authenticate


  end


  def all_notifications
     @notys = Audit.notys(current_user.id)
     render 'shared/all_notifications'
  end

  def limited_notifications
     @notys = Audit.notys(current_user.id,10)
     # uncomment the following line to remove showing the badge from first click
     # Audit.set_all_checked(current_user.id)
     render partial: 'shared/notifications'
  end

  def set_checked_true
    Audit.set_checked(params[:aid])
    head :ok, :content_type => 'text/html'
  end

  def set_all_checked_true
    Audit.set_all_checked(params[:uid])
    head :ok, :content_type => 'text/html'
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

    contract = Partner.find(@ins_id).contracts.first
    if @form_country_id.to_i == 0
      @co_id = @model.camelize.constantize.find(@item_id).country_id
    else
      @co_id = @form_country_id.to_i
    end

    if contract.nil?
      @out = "No contract created for this partner, skipping recruitment territory validation!"
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
              @out = "This students country of origin is a prohibited territory as per this partners contract"
            else
              @out = "Not a prohibited territory!"
            end

            if !per.empty? && per.include?(@co_id.to_i)
              @out = "Permitted territory!"
            else
              @out = "This students country of origin is not a permitted territory as per this partners contract"
            end
        end
    elsif @co_id.nil?
      @out = "Nationality for this student is not selected, skipping recruitment territory validation!"
    end

    render text: @out

  end

  def group_assign
    set_url_params
    model = @model.camelize.constantize
    authorize! :update, model

    ids = params[:model_ids].split(",")

    to_update = model.where(id: ids)
    to_update.update_all(branch_id: params[:branch_id],
                         assigned_to: params[:user_id],
                         assigned_by: current_user.id,
                         assigned_at: Time.now)
    # this is because the update_all does not triiger updated_at to update itself
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

  private

  def set_last_seen_at
    current_user.update_attribute(:last_seen_at, Time.now)
    session[:last_seen_at] = Time.now
  end

  def set_current_user
    User.current = current_user
  end

  def ban_ip
    if (!current_user.adm? rescue nil)
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
      "passwords"
    elsif is_a?(Users::InvitationsController)
      false
    elsif is_a?(Devise::ConfirmationsController)
      false
    elsif current_registration
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
