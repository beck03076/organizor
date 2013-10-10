class EnquiryStatus < ActiveRecord::Base
  has_many :enquiries,foreign_key: "status_id"
  attr_accessible :desc, :name
end
