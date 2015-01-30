class TaskTopic < ActiveRecord::Base
  has_many :tasks, class_name: "Task", foreign_key: "topic_id"
  attr_accessible :desc, :name
  
  
  def user_tasks(u_id)
    self.tasks.where(assigned_to: u_id)
  end
end
