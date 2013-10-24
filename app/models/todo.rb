class Todo < ActiveRecord::Base
  belongs_to :enquiry
  belongs_to :registration
  belongs_to :topic, class_name: "TodoTopic", foreign_key: "topic_id"
  belongs_to :status, class_name: "TodoStatus", foreign_key: "status_id"
  belongs_to :user, class_name: "User", foreign_key: "assigned_to"
  belongs_to :_invited_by, class_name: "User",foreign_key: "invited_by_id"
  
  
  attr_accessible :created_by, :desc, :duedate, 
  :priority, :status_id, :topic_id, 
  :updated_by,:assigned_to, :assigned_by,
  :enquiry_id,:registration_id,:done
  
  def ass_to
    User.find(self.assigned_to).first_name
  end
  
  def ass_by
    User.find(self.assigned_by).first_name
  end

  def due
    self.duedate.strftime("%F")
  end
  
end
