class ProhibitedCountry < ActiveRecord::Base
  attr_accessible :contract_id, :country_id
  belongs_to :contract
  belongs_to :country 

end
