class InstitutionGroup < ActiveRecord::Base
  attr_accessible :created_by, :desc, :name, :updated_by
  
  has_many :institutions, foreign_key: 'group_id'
end
