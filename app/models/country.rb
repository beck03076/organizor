class Country < ActiveRecord::Base
  
  has_many :preferred_countries
  has_many :enquiries, :through => :preferred_countries
    
  has_many :cities
  has_many :institutions
  
  has_one :enquiry
  has_one :registration
  
  accepts_nested_attributes_for :preferred_countries
end
