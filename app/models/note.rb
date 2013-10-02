class Note < ActiveRecord::Base
  
  belongs_to :enquiry  
  attr_accessible :content, :sub_class, :sub_id
end
