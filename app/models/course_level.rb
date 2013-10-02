class CourseLevel < ActiveRecord::Base
  has_many :programmes

  attr_accessible :created_by, :desc, :name, :updated_by
end
