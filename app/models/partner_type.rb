class PartnerType < ActiveRecord::Base

  attr_accessible :created_by, :desc, :name, :updated_by,:educational
  
  has_many :partners, foreign_key: 'type_id'
  has_many :programmes
  
  def self.edu
    where(educational: true).order(:name)
  end
  
end
