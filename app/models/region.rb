class Region < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :countries
end
