class Country < ActiveRecord::Base
   attr_accessible :name
  
  has_many :preferred_countries
  has_many :enquiries, :through => :preferred_countries
    
  has_many :cities
  has_many :institutions
  has_many :people
  has_many :users
  
  has_many :programmes
  has_many :registrations, through: :programmes
  
  accepts_nested_attributes_for :preferred_countries
  
  has_many :prohibited_countries
  has_many :contracts, :through => :prohibited_countries
  
  belongs_to :region
  
  has_one :currency
end
