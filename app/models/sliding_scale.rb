class SlidingScale < ActiveRecord::Base
  attr_accessible :commission_percentage, :contract_id, :course_level_id, 
  :from, :to,:second_year,:third_year,
  :course_level_tokens,:sliding_ranges_attributes
  has_and_belongs_to_many :course_levels
  belongs_to :contract
  has_and_belongs_to_many :sliding_ranges
  
  
  attr_reader :course_level_tokens
  
  accepts_nested_attributes_for :sliding_ranges
  
  def course_level_name
    self.course_levels.map &:name  rescue nil
  end
  
  def course_level_tokens=(list)
    self.course_level_ids = list.split(',')
  end
end
