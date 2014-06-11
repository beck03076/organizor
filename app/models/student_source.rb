class StudentSource < ActiveRecord::Base

  has_many :enquiries
  has_many :registrations

  belongs_to :contact_type
  
  attr_accessible :contact_type_id, :desc, :name
end
