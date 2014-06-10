class FollowUp < ActiveRecord::Base

  include ActionsModel
  
  belongs_to :follow_upable, polymorphic: true
  belongs_to :event_type
  
  attr_accessible :api, :created_by, :desc, 
  :ends_at, :event_type_id, :remind_before, 
  :starts_at, :title, :updated_by, :venue,
  :enquiry_id, :assigned_to, :assigned_by,
  :registration_id,:institution_id,:ref_no,
  :followed,:auto

  notifiably_audited alert_for: [[[:assigned_to],"FollowUp assigned","This follow up has been reassigned to you"]],
                                 title: :title,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Some values of this <<here>> has been updated",
                                 alert_to: :assigned_by

  
  scope :between, lambda {|start_time, end_time|  
   {:conditions => ["? < start < ?", FollowUp.format_date(start_time),FollowUp.format_date(end_time)] }  
  }  

  after_save :set_followed_at

  def set_followed_at
    return if !followed_changed?
   
    update_column(:followed_at,(followed ? Time.now : nil))
  end
  
  def self.format_date(date_time)  
   Time.at(date_time.to_i).to_formatted_s(:db)  
  end 
  
  def as_json(options = {})  
   {  
    :id => self.id,  
    :title => self.title,  
    :description => self.desc || "",  
    :start => self.starts_at.rfc822,  
    :end => (self.ends_at.nil? ? self.starts_at.rfc822 : self.ends_at.rfc822),  
    #:allDay => self.allday,  
    :recurring => false,  
    :url => Rails.application.routes.url_helpers.follow_up_path(id),  
    :className => "follow_up_item",
   }  
  end 

  def event_type_name
    event_type.name rescue "Unknown"
  end
  
  def tit
    self.title rescue "Title Unknown"
  end
  
  def ref_no=(r)
    self.registration_id = Registration.find_by_ref_no(r).id rescue Registration.first.id
  end
  
  def ref_no
    Registration.find(registration_id).ref_no rescue "No Registration"
  end
  
  def asso_with
    [parent.id,parent.name,@core_name.pluralize.downcase,@core_name]
  end
  
end
