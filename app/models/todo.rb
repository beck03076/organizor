class Todo < ActiveRecord::Base
  include ActionsModel
  
  belongs_to :todoable, polymorphic: true
  belongs_to :topic, class_name: "TodoTopic", foreign_key: "topic_id"
  #belongs_to :status, class_name: "TodoStatus", foreign_key: "status_id"
  belongs_to :user, class_name: "User", foreign_key: "assigned_to"
  belongs_to :a2, class_name: "User", foreign_key: "assigned_by"
  belongs_to :_invited_by, class_name: "User",foreign_key: "invited_by_id"

  notifiably_audited alert_for: [[[:assigned_to],"Todo assigned","This todo has been reassigned to you"]],
                                 title: :title,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Some values of this <<here>> has been updated"
  
  
  attr_accessible :created_by, :desc, :duedate, 
  :priority, :status_id, :topic_id, 
  :updated_by,:assigned_to, :assigned_by,
  :enquiry_id,:registration_id,:done,
  :institution_id,:done_at,:api,:title,
  :ref_no,:auto
  
  def as_json(options = {})  
   {  
    :id => self.id,  
    :title => (self.title rescue self.topic.name),  
    :description => self.desc || "No Description",  
    :status => (self.status.name rescue "No Status"),
    :start => (self.duedate.rfc822 rescue nil),  
    :end => (self.duedate.rfc822 rescue nil),  
    #:allDay => self.allday,  
    :priority => self.priority,  
    :url => Rails.application.routes.url_helpers.todo_path(id),  
    :className => "todo_item",
   }  
  end

  after_save :set_done_at
  
  scope :todays, where("date(duedate) = '#{Date.today.to_s(:db)}'")
                               
  scope :this_weeks, where("date(duedate) BETWEEN '#{Date.today.at_beginning_of_week.to_s(:db)}' AND '#{Date.today.at_end_of_week.to_s(:db)}'")
                                   
  scope :this_months, where("date(duedate) BETWEEN '#{Date.today.at_beginning_of_month.to_s(:db)}' AND '#{Date.today.at_end_of_month.to_s(:db)}'")
  
  def set_done_at
    return if !done_changed?
   
    update_column(:done_at,(done ? Time.now : nil))
  end

  
  def status
    self.done ? "Completed" : "Needs Action"
  end
    
  def ass_to
    User.find(self.assigned_to).first_name
  end
  
  def ass_by
    User.find(self.assigned_by).first_name
  end

  def due
    self.duedate.strftime("%A, %F") rescue nil
  end
  
  def comp
    self.done_at.strftime("%A, %F") rescue nil
  end
  
  def uptd
    self.updated_at.strftime("%A, %F") rescue nil
  end  
  
  def topic_name
    self.topic.name rescue "Title Unknown"
  end
  
  def stat
    self.status.name rescue "Title Unknown"
  end
 

  
end
