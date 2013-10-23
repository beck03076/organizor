class Role < ActiveRecord::Base
  audited
  has_many :users
  has_and_belongs_to_many :permissions
  attr_accessible :name,:permission_ids,:desc,
                  :created_by,:updated_by
  accepts_nested_attributes_for :permissions
end
