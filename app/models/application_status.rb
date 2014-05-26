class ApplicationStatus < ActiveRecord::Base

  has_many :programmes, foreign_key: "app_status_id"
  has_many :registrations, through: :programmes
  
  attr_accessible :desc, :name

 
end
