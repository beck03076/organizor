class Ability
  include CanCan::Ability
  
  def initialize(user)
      user.permissions.each do |permission|
        if permission.subject_id.nil?
          if permission.subject_class == "All"
            can permission.action.to_sym, :all
          else
            can permission.action.to_sym, permission.subject_class.constantize
          end
        else
          can permission.action.to_sym, permission.subject_class.constantize, :id => user.id
          p "********************&&&&&&&&&&&&****"
          p user.id
        end
      end
  end
  
end
