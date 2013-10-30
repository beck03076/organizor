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
                 @user.permissions << Role.find(params[:role_id]).permissions
               end
      end
    end
    redirect_to root_path
  end
  
  def after_accept_path_for(resource)
    resource
  end

end
