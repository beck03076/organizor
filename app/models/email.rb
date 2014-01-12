class Email < ActiveRecord::Base
  has_and_belongs_to_many :enquiries 
  belongs_to :smtp
  has_and_belongs_to_many :registrations
  has_and_belongs_to_many :institutions
  

  
  belongs_to :_from, class_name: "Smtp",foreign_key: "smtp_id"
  
  attr_accessible :attachment, :bcc, :body, 
  :cc, :created_by, :enquiry_id, 
  :from, :registration_id, :subject, 
  :to, :updated_by, :user_id, 
  :smtp_id,:signature,:enquiry_ids,:registration_ids,:institution_ids
  
  accepts_nested_attributes_for :enquiries
  
end
