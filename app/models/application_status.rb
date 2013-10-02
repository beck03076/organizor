class ApplicationStatus < ActiveRecord::Base

  has_many :programmes
  attr_accessible :desc, :name
end
