class City < ActiveRecord::Base
  has_many :institutions  
  belongs_to :country

end
