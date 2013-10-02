class Status < ActiveRecord::Base
  has_many :enquiries
  attr_accessible :desc, :name
end
