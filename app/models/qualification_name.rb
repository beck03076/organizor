class QualificationName < ActiveRecord::Base
  has_many :qualifications
  attr_accessible :created_by, :desc, :name, :updated_by
end
