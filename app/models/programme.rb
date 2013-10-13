class Programme < ActiveRecord::Base
  belongs_to :enquiry
  belongs_to :registration
  belongs_to :course_level, :foreign_key => 'level_id'
  belongs_to :country
  belongs_to :city
  belongs_to :institution
  belongs_to :programme_type, :foreign_key => 'type_id'
  belongs_to :course_subject, :foreign_key => 'subject_id'
  belongs_to :application_status,:foreign_key => 'app_status_id'
  
  belongs_to :_created_by, class_name: "User",foreign_key: "created_by"
  belongs_to :_updated_by, class_name: "User",foreign_key: "updated_by"
  
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Programme"'
  
  attr_accessible :city_id, :country_id, :created_by, 
                  :end_date, :enquiry_id, :institution_id, 
                  :level_id, :start_date, :subject_id, 
                  :type_id, :updated_by, :course_subject,
                  :app_status_id,:ins_ref_no,:registration_id,
                  :course_subject_text,:notes_attributes
                  
  accepts_nested_attributes_for :notes
end
