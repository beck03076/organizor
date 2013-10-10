class Note < ActiveRecord::Base
  
  belongs_to :enquiry  
  belongs_to :registration
  attr_accessible :content, :sub_class, :sub_id
end
