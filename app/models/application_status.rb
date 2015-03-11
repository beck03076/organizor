class ApplicationStatus < ActiveRecord::Base

  has_many :programmes, foreign_key: "app_status_id"
  has_many :registrations, through: :programmes
  belongs_to :email_template


  attr_accessible :desc, :name, :email_template_id


end
