class FollowUp < ActiveRecord::Base
  belongs_to :enquiry
  belongs_to :event_type
  belongs_to :registration
  belongs_to :enquiries,class_name: "Enquiry",foreign_key: "enquiry_id"
  belongs_to :institution
  
  attr_accessible :api, :created_by, :desc, 
  :ends_at, :event_type_id, :remind_before, 
  :starts_at, :title, :updated_by, :venue,
  :enquiry_id, :assigned_to, :assigned_by,
  :registration_id,:institution_id,:ref_no

  
  scope :between, lambda {|start_time, end_time|  
   {:conditions => ["? < start < ?", FollowUp.format_date(start_time),FollowUp.format_date(end_time)] }  
  }  
  
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
  
  def tit
    self.title rescue "Title Unknown"
  end
  
  def ref_no=(r)
    self.registration_id = Registration.find_by_ref_no(r) rescue Registration.first.id
  end
  
  def ref_no
    Registration.find(registration_id).ref_no rescue "No Registration"
  end
  
end
