class Audit < ActiveRecord::Base
 
  attr_accessible :auditable_id, :auditable_type,:action, :user_id, :comment, :created_at
end
