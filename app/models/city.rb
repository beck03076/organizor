class City < ActiveRecord::Base 
	attr_accessible :name, :country_id

  has_many :institutions  
  has_many :people
  belongs_to :country

end
