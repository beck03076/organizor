class PartnerType < ActiveRecord::Base

  attr_accessible :created_by, :desc, :name, :updated_by,:partner_category_id
  
  has_many :partners, foreign_key: "type_id"
  has_many :programmes
  belongs_to :partner_category
  
  def self.edu
    PartnerCategory.find_by_name("educational").partner_types
  end
  
end
