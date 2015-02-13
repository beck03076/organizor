class PartnerDocCategory < ActiveRecord::Base
  has_many :documents
  attr_accessible :created_by, :desc, :name, :updated_by
end
