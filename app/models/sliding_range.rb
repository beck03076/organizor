class SlidingRange < ActiveRecord::Base
  attr_accessible :commission_percentage, :from, :to
  has_and_belongs_to_many :sliding_scales
end
