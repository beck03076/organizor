class Exam < ActiveRecord::Base

  belongs_to :registration
  belongs_to :exam_type
  belongs_to :english_level,foreign_key: "eng_level_id"
  
  attr_accessible :exam_date, :exam_score, :exam_type_id, :registration_id,:eng_level_id
  
  def english_level_name
    self.english_level.name rescue "Unknown"
  end
  
  def exam_type_name
    self.exam_type.name rescue "Unknown"
  end
end
