class RegistrationAbility
  include CanCan::Ability
  
  def initialize(user)
      user.permissions.each do |permission|
        if permission.subject_id.nil?
          if permission.subject_class == "All"
            can permission.action.to_sym, :all
          else
            can permission.action.to_sym, permission.subject_class.constantize
          end
        elsif permission.subject_id == 1
          can permission.action.to_sym, permission.subject_class.constantize, users: { id: user.id }
        end        
      end
  end
  
end
