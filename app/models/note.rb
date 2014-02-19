class Note < ActiveRecord::Base
  
  belongs_to :enquiry  
  belongs_to :registration
  belongs_to :institution
  belongs_to :programme
  attr_accessible :content, :sub_class, :sub_id
  
  def safe_content
    self.content.html_safe
  end

end
