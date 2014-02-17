class SlidingScale < ActiveRecord::Base
  attr_accessible :commission_percentage, :contract_id, :course_level_id, :from, :to
  belongs_to :course_level
  belongs_to :contract
end
