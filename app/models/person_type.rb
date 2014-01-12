class PersonType < ActiveRecord::Base
  attr_accessible :created_by, :desc, :name, :updated_by
  has_many :people, foreign_key: 'type_id'
end
