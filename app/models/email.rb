class Email < ActiveRecord::Base
  belongs_to :enquiry 
  belongs_to :smtp
  
  
  
  
  attr_accessible :attachment, :bcc, :body, 
  :cc, :created_by, :enquiry_id, 
  :from, :registration_id, :subject, 
  :to, :updated_by, :user_id, 
  :smtp_id,:signature
end
