class Email < ActiveRecord::Base
  include ActionsModel

  has_and_belongs_to_many :enquiries, :uniq => true  
  has_and_belongs_to_many :registrations, :uniq => true  
  has_and_belongs_to_many :institutions, :uniq => true  
  has_and_belongs_to_many :people, :uniq => true  

  
  belongs_to :by,class_name: "User",foreign_key: "created_by"   
  belongs_to :_from, class_name: "Smtp",foreign_key: "smtp_id"

  belongs_to :smtp
  
  attr_accessible :attachment, :bcc, :body, 
  :cc, :created_by, :enquiry_id, 
  :from, :registration_id, :subject, 
  :to, :updated_by, :user_id, 
  :smtp_id,:signature,:enquiry_ids,:registration_ids,:institution_ids,
  :auto,:core

  
  accepts_nested_attributes_for :enquiries

  before_create :set_from
  after_create :send_mail,:set_response_time

  def set_from
    self.from = _from.name
  end

  def send_mail
    UserMailer.send_email(self,self.smtp_id).deliver
  end

  def set_response_time
    return if auto
   
    send(core).where('response_time IS NULL').each do |item|
      next if item.assigned_at.nil?
      response_time = ((created_at - item.assigned_at) / 3600).round(2)      
      item.update_attribute(:response_time, response_time)       
    end
  end
end
