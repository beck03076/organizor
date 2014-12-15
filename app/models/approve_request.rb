class ApproveRequest < ActiveRecord::Base
	serialize :values, Hash
	belongs_to :registration
  attr_accessible :approved, :registration_id, :request_to, :values
end
