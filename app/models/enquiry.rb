class Enquiry < ActiveRecord::Base
  validates :first_name, 
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another enquiry, please check!" }
  
  audited
  mount_uploader :image, HumanImageUploader
  
  has_many :preferred_countries
  has_many :countries, :through => :preferred_countries
  
  has_many :programmes
  belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
             
  belongs_to :status, class_name: "EnquiryStatus",foreign_key: "status_id"
  belongs_to :contact_type
  
  belongs_to :student_source,:foreign_key => "source_id"
  
  has_and_belongs_to_many :emails
  
  has_many :follow_ups
  
  has_many :todos
  
  belongs_to :users, class_name: "User"
  
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Enquiry"'
  
  scope :inactive,includes(:status,
                           :follow_ups,
                           :country_of_origin).where("enquiry_statuses.name = 'deactivated'")
  scope :active, includes(:status,
                          :follow_ups,
                          :country_of_origin).where("enquiry_statuses.name != 'deactivated'")
  
  #scope :inactive,includes(:status).where("enquiry_statuses.name = 'deactivated'")
  
  scope :myactive, lambda{|user|
  if user.adm?
    includes(:status,
             :follow_ups,
             :country_of_origin,
             :_ass_to,:_upd_by).where("enquiry_statuses.name != 'deactivated'")
  else
    includes(:status,
             :follow_ups,
             :country_of_origin,
             :user).where("enquiry_statuses.name != 'deactivated' AND enquiries.assigned_to = #{user.id}")
  end
  }
  
  
  scope :todays, where("enquiries.id IN (SELECT fu.enquiry_id FROM follow_ups fu 
                               WHERE date(fu.starts_at) = '#{Date.today}')")
                               
  scope :this_weeks, where("enquiries.id IN (SELECT fu.enquiry_id FROM follow_ups fu 
                                   WHERE date(fu.starts_at) BETWEEN '#{Date.today.at_beginning_of_week}' AND '#{Date.today.at_end_of_week}')")
                                   
  scope :this_months, where("enquiries.id IN (SELECT fu.enquiry_id FROM follow_ups fu 
                                   WHERE date(fu.starts_at) BETWEEN '#{Date.today.at_beginning_of_month}' AND '#{Date.today.at_end_of_month}')")

  
  attr_accessible :emails_attributes,:programmes_attributes,
                  :assigned_by, :assigned_to, :created_by, 
                  :date_of_birth, :email1, :email2, 
                  :first_name, :gender, :mobile1, 
                  :mobile2, :score, :source_id, 
                  :surname, :updated_by,:country_ids,
                  :name,:address,:status_id,:country_id,
                  :follow_ups_attributes,:active,:notes_attributes,
                  :todos_attributes,:contact_type_id,:registered,
                  :image,:remote_image_url
                  
  accepts_nested_attributes_for :programmes,:emails,:follow_ups,:notes,:todos, :allow_destroy => true
  
  def dob
   self.date_of_birth.strftime("%d-%m-%Y") rescue "Not Captured"
  end
  
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def contact_type_name
    self.contact_type.name rescue "Unknown"
  end
  
  def status_name
    self.status.name rescue "Unknown"
  end
  
  def country_of_origin_name
    self.country_of_origin.name rescue "Unknown"
  end
  
  def tit
    self.first_name rescue "Title Unknown"
  end
  
  def self.tit
    "Enquiries"
  end
  
  def follow_up_date
    out = self.follow_ups.map{|i| dat(i.starts_at) }.sort
    out.size > 1 ? out[0] + "<span title='#{out.join(", ")}' class=tooltip>...</span>".html_safe : out[0]
  end
  
  
  def self.no_followups
    includes(:follow_ups).where( :follow_ups => {:enquiry_id => nil} )
  end

end
