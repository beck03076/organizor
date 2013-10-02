class Qualification < ActiveRecord::Base
  has_many :registrations,foreign_key: 'qua_id'
   
  attr_accessible :desc, :name
end
