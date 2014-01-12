class PermittedCountries < ActiveRecord::Base
  attr_accessible :contract_id, :country_id
end
