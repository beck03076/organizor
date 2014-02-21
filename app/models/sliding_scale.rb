class SlidingScale < ActiveRecord::Base
  attr_accessible :commission_percentage, :contract_id, :course_level_id, :from, :to,:course_level_tokens
  has_and_belongs_to_many :course_levels
  belongs_to :contract
  attr_reader :course_level_tokens
  
  def course_level_name
    self.course_levels.map &:name  rescue nil
  end
  
  def course_level_tokens=(list)
    self.course_level_ids = list.split(',')
  end
end
