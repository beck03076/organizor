class PermittedRegions < ActiveRecord::Base
  attr_accessible :contract_id, :region_id
end
