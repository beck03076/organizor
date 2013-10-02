class EmailTemplate < ActiveRecord::Base
  attr_accessible :body, :created_by, :desc, :name, :signature, :subject, :updated_by
end
