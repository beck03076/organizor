class ExamType < ActiveRecord::Base
  belongs_to :exam
  attr_accessible :desc, :name
end
