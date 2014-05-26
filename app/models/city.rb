class City < ActiveRecord::Base 
	attr_accessible :name, :country_id

  has_many :institutions  
  belongs_to :country

end
