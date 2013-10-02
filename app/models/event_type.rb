class EventType < ActiveRecord::Base
  has_many :follow_ups
  attr_accessible :desc, :name
end
