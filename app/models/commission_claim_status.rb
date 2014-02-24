class CommissionClaimStatus < ActiveRecord::Base
  attr_accessible :created_by, :desc, :name, :updated_by
  
  has_many :programmes
end
