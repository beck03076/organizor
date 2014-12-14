class ApproveRequest < ActiveRecord::Base
	serialize :values, Hash
  attr_accessible :approved, :registration_id, :request_to, :values
end
