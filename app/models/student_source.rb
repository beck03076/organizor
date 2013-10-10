class StudentSource < ActiveRecord::Base
  has_many :enquiries
  has_many :registrations
  attr_accessible :contact_id, :desc, :name
end
