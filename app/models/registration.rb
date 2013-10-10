class Registration < ActiveRecord::Base
  audited
  belongs_to :qualification, foreign_key: 'qua_id'
  belongs_to :country

  has_many :programmes, dependent: :destroy
  has_many :exams
  has_many :proficiency_exams,class_name: "Exam"
  belongs_to :sub_agent
  belongs_to :student_source, foreign_key: 'reg_source_id'  
  
  has_many :documents, dependent: :destroy
  
   belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
   belongs_to :address_country,
             :class_name => "Country",
             :foreign_key => "address_country_id"
             
  belongs_to :english_level, foreign_key: 'prof_eng_level_id',class_name: "EnglishLevel"
  
  has_many :emails
  has_many :follow_ups
  has_many :notes,foreign_key: "sub_id"
  has_many :todos

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
  :note,:documents_attributes
  
  accepts_nested_attributes_for :programmes, :proficiency_exams, :documents, :allow_destroy => true
  
  
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def ass_to
    User.find(self.assigned_to).name.titleize.strip rescue ""
  end
  
  def ass_by
    User.find(self.assigned_by).name.titleize.strip rescue ""
  end

  def cre_by
    User.find(self.created_by).name.titleize.strip rescue ""
  end

  def upd_by
    User.find(self.updated_by).name.titleize.strip rescue ""
  end
  
  def statuses
    self.programmes.map{|i| i.application_status.try(:name)} rescue ""
  end

  def address
    [self.address_line1.to_s,
     self.address_line2.to_s,
     self.address_city.to_s,
     self.address_country.try(:name).to_s,
     self.address_post_code.to_s].join(', ').strip
  end
  
end
