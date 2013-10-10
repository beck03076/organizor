class FollowUp < ActiveRecord::Base
  belongs_to :enquiry
  belongs_to :event_type
  belongs_to :registration
  
  attr_accessible :api, :created_by, :desc, 
  :ends_at, :event_type_id, :remind_before, 
  :starts_at, :title, :updated_by, :venue,
  :enquiry_id, :assigned_to, :assigned_by,
  :registration_id
end
