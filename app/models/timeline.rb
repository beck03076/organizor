class Timeline < ActiveRecord::Base
  attr_accessible :a_id, :a_name, :created_at, 
  :desc, :m_id, :m_name, :user_id, 
  :user_name, :comment, :action, :receiver_id, :checked
end
