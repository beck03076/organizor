class Registration < ActiveRecord::Base
  
  belongs_to :qualification, foreign_key: 'qua_id'
  belongs_to :country

  has_many :programmes
  has_many :exams
  has_many :proficiency_exams,class_name: "Exam"
  belongs_to :sub_agent
  belongs_to :student_source, foreign_key: 'reg_source_id'  

  attr_accessible :address_city, :address_country_id, :address_line1, 
  :address_line2, :address_others, :address_post_code, 
  :assigned_by, :assigned_to, :country_id, 
  :course_id, :created_by, :date_of_birth, 
  :email1, :email2, :emer_email, 
  :emer_full_name, :emer_mobile, :emer_relationship, 
  :first_name, :flight_airport, :flight_arrival_date, 
  :flight_arrival_time, :flight_no, :gender, 
  :home_phone, :mobile1, :mobile2, 
  :passport_number,:prof_eng_level_id, :prof_exam_id, :qua_exam, 
  :qua_grade, :qua_id, :qua_institution, :qua_score, 
  :qua_subject, :ref_no, :reg_came_through, 
  :reg_direct, :reg_source_id, :sub_agent_id, 
  :surname, :updated_by, :passport_valid_till, 
  :visa_valid_till, :visa_type, :work_phone,
  :programmes_attributes,:proficiency_exams_attributes,
  :note
  
  accepts_nested_attributes_for :programmes, :proficiency_exams
end
