class Todo < ActiveRecord::Base
  audited
  belongs_to :enquiry
  belongs_to :registration
  belongs_to :topic, class_name: "TodoTopic", foreign_key: "topic_id"
  belongs_to :status, class_name: "TodoStatus", foreign_key: "status_id"
  belongs_to :user, class_name: "User", foreign_key: "assigned_to"
  belongs_to :a2, class_name: "User", foreign_key: "assigned_by"
  belongs_to :_invited_by, class_name: "User",foreign_key: "invited_by_id"
  
  
  attr_accessible :created_by, :desc, :duedate, 
  :priority, :status_id, :topic_id, 
  :updated_by,:assigned_to, :assigned_by,
  :enquiry_id,:registration_id,:done
  
  def as_json(options = {})  
   {  
    :id => self.id,  
    :title => (self.topic.name rescue "Untitled"),  
    :description => self.desc || "No Description",  
    :status => (self.status.name rescue "No Status"),
    :start => (self.duedate.rfc822 rescue nil),  
    :end => (self.duedate.rfc822),  
    #:allDay => self.allday,  
    :priority => self.priority,  
    :url => Rails.application.routes.url_helpers.todo_path(id),  
    :className => "todo_this",
   }  
  end
  
  def ass_to
    User.find(self.assigned_to).first_name
  end
  
  def ass_by
    User.find(self.assigned_by).first_name
  end

  def due
    self.duedate.strftime("%A, %F") rescue "Not Set"
  end
  
  def tit
    self.topic.name rescue "Title Unknown"
  end
  
  def stat
    self.status.name rescue "Title Unknown"
  end
 

  
end
