class Exam < ActiveRecord::Base

  belongs_to :registration,class_name: "Registration", foreign_key: "prof_exam_id"
  belongs_to :exam_type
  belongs_to :proficiency
  
  attr_accessible :exam_date, :exam_score, :exam_type_id, :registration_id
end
