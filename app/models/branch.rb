class Branch < ActiveRecord::Base
  attr_accessible :created_by, :desc, :name, 
  :updated_by,:managed_by,:email,:phone,:fax,
  :address_line1,:address_line2,:address_post_code,
  :city_id,:country_id
end
