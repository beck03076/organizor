class Users::InvitationsController < Devise::InvitationsController
  layout false, only: :edit
  def create
    params[:email].values.each do |email_id|
      if !email_id.blank?
             @user = User.invite!(email: email_id)
             @user.conf = UserConfig.first.dup
             
               if !params[:role_id].blank?
                 @user.update_attribute(:role_id, params[:role_id])
                 @user.update_attribute(:invited_by_id,current_user.id)
                 @user.update_attribute(:is_active, true)
                 @user.permissions << Permission.where(subject_class: "User", action: ["update","read"])
                 @user.permissions << Role.find(params[:role_id]).permissions
               end
      end
    end
    flash[:notice] = "User(s) - #{params[:email].values.reject{|i| i.blank? }.join(", ")} are invited succesfully" 
    redirect_to users_path
  end
  
  def after_accept_path_for(resource)
    resource
  end

end
