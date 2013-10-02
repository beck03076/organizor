class EnquirySource < ActiveRecord::Base
  has_many :enquiries
  attr_accessible :created_by, :desc, :name, :updated_by
end
