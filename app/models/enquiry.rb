class Enquiry < ActiveRecord::Base
  include CoreExtension
  
  validates :first_name, on: :create,
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another enquiry, please check!" }
  
  audited
  mount_uploader :image, HumanImageUploader
  
  belongs_to :branch
  belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
  belongs_to :status, class_name: "EnquiryStatus",foreign_key: "status_id"
  belongs_to :contact_type  
  belongs_to :student_source,:foreign_key => "source_id"
  belongs_to :users, class_name: "User"  
  
  has_many :preferred_countries
  has_many :countries, :through => :preferred_countries  
  has_many :programmes
  has_and_belongs_to_many :emails
  has_many :follow_ups
  has_many :todos
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Enquiry"'
  
  has_and_belongs_to_many :institutions
  
  scope :inactive,includes(:status,
                           :follow_ups,
                           :country_of_origin).where("enquiry_statuses.name = 'deactivated'")
  scope :active, includes(:status,
                          :follow_ups,
                          :country_of_origin).where("enquiry_statuses.name != 'deactivated'")
                          
  belongs_to :branch
  belongs_to :student_source, foreign_key: 'source_id'
  
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
             :country_of_origin).where("enquiry_statuses.name != 'deactivated' AND enquiries.assigned_to = #{user.id}")
  end
  }


  
  attr_accessible :emails_attributes,:programmes_attributes,
                  :assigned_by, :assigned_to, :created_by, 
                  :date_of_birth, :email1, :email2, 
                  :first_name, :gender, :mobile1, 
                  :mobile2, :score, :source_id, 
                  :surname, :updated_by,:country_ids,
                  :name,:address,:status_id,:country_id,
                  :follow_ups_attributes,:active,:notes_attributes,
                  :todos_attributes,:contact_type_id,:registered,
                  :image,:remote_image_url,:branch_id
                  
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
  
  def cur_cl
    @current_cl
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
  
  def source_name
    self.student_source.name rescue "Unknown"
  end
  
  def nationality
    self.country_of_origin.name rescue "Unknown"
  end
  
end
