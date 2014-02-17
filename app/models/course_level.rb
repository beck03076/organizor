class CourseLevel < ActiveRecord::Base
  has_many :programmes, foreign_key: "level_id"

  attr_accessible :created_by, :desc, :name, :updated_by
  
  
end
