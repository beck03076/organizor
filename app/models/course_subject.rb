class CourseSubject < ActiveRecord::Base
  has_many :programmes
  belongs_to :programme_type
   
  attr_accessible :created_by, :desc, :name, :updated_by
end
