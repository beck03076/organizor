class StudentSource < ActiveRecord::Base
  has_many :enquiries,:foreign_key => "source_id"
  has_many :registrations
  attr_accessible :contact_id, :desc, :name
end
