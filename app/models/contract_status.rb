class ContractStatus < ActiveRecord::Base
  has_many :contracts
  attr_accessible :desc, :name
end
