class PartnerCategory < ActiveRecord::Base
  attr_accessible :created_by, :desc, :name, :updated_by

  has_many :partner_types
  has_many :partners, foreign_key: "category_id" 
end
