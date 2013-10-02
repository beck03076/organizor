class Proficiency < ActiveRecord::Base
  has_one :english_level
  has_many :exams
  
  attr_accessible :prof_eng_level_id, :prof_exam_id,:exams_attributes
  accepts_nested_attributes_for :exams
end
