class Institution < ActiveRecord::Base
  attr_accessible :city_id, :country_id, :created_by, :name, :poc, :type_id, :updated_by
end
