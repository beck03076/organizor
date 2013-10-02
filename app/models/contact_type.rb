class ContactType < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :enquiries
  
end
