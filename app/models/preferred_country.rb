class PreferredCountry < ActiveRecord::Base
  belongs_to :enquiry
  belongs_to :country

  attr_accessible :country_id, :enquiry_id, :priority

end
