class Note < ActiveRecord::Base
  
  belongs_to :enquiry  
  belongs_to :registration
  belongs_to :programme
  attr_accessible :content, :sub_class, :sub_id
  
  belongs_to :_created_by, class_name: "User",foreign_key: "created_by"
  belongs_to :_updated_by, class_name: "User",foreign_key: "updated_by"
end
