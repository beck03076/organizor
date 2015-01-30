class Email < ActiveRecord::Base
  include ActionsModel
  mount_uploader :attachment, AttachmentUploader

  has_and_belongs_to_many :enquiries, :uniq => true  
  has_and_belongs_to_many :registrations, :uniq => true  
  has_and_belongs_to_many :partners, :uniq => true  
  has_and_belongs_to_many :people, :uniq => true  

  
  belongs_to :by,class_name: "User",foreign_key: "created_by"   
  belongs_to :_from, class_name: "Smtp",foreign_key: "smtp_id"

  belongs_to :smtp
  
  attr_accessible :attachment, :bcc, :body, 
  :cc, :created_by, :enquiry_id, 
  :from, :registration_id, :subject, 
  :to, :updated_by, :user_id, 
  :smtp_id,:signature,:enquiry_ids,:registration_ids,:partner_ids,
  :auto,:core

  
  accepts_nested_attributes_for :enquiries

  before_create :set_from
  after_save :set_response_time, :send_mail

  def set_from
    self.from = _from.name
  end

  def send_mail
    BackgroundJob.delay_for(5.seconds).email(self.id)
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
