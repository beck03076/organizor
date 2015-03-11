class EmailTemplate < ActiveRecord::Base
  has_one :application_status
  attr_accessible :body, :created_by, :desc, :name, :signature, :subject, :updated_by
end
