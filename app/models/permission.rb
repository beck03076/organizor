class Permission < ActiveRecord::Base
  audited
  has_and_belongs_to_many :users
  has_and_belongs_to_many :roles
  attr_accessible :action, :description, :name, :subject_class, :subject_id, :user_id,:subject_var
end
