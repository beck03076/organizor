class Todo < ActiveRecord::Base
  belongs_to :enquiry
  belongs_to :topic, class_name: "TodoTopic", foreign_key: "topic_id"
  belongs_to :status, class_name: "TodoStatus", foreign_key: "status_id"
  attr_accessible :created_by, :desc, :duedate, 
  :priority, :status_id, :topic_id, 
  :updated_by,:assigned_to, :assigned_by,
  :enquiry_id  
end
