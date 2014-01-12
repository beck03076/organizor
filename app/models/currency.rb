class Currency < ActiveRecord::Base
  attr_accessible :code, :country_id, :country_name, 
  :iso_alpha2, :iso_alpha3, :iso_numeric, 
  :name, :symbol
  
  belongs_to :country
end
