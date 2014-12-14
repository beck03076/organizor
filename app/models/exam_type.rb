class ExamType < ActiveRecord::Base
  has_many :exams
  attr_accessible :desc, :name
  has_many :registrations
end
