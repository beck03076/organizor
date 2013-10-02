class RegCourse < ActiveRecord::Base
 
  belongs_to :status, :foreign_key => 'app_status_id'
  belongs_to :city
  belongs_to :country
  belongs_to :course_level
  belongs_to :institution
  belongs_to :programme_type
  belongs_to :registration

  attr_accessible :app_status_id, :city_id, :country_id, 
  :course_level_id, :course_subject, :end_date, 
  :ins_ref_no, :institution_id, :programme_type_id, 
  :start_date, :registration_id
end
