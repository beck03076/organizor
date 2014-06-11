class ContactType < ActiveRecord::Base
  attr_accessible :desc, :name


  has_many :enquiries
  has_many :registrations
  has_many :student_sources
  
end
