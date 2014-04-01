class EnquiryStatus < ActiveRecord::Base
  has_many :enquiries,foreign_key: "status_id"
  attr_accessible :desc, :name, :cl
  scope :de, where("name = 'deactivated'").select("id")
  scope :fo, where("name = 'following'").select("id")
  
end
