class Enquiry < ActiveRecord::Base
  audited
  
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
  
  has_many :notes,foreign_key: "sub_id"
  
  belongs_to :_assigned_by, class_name: "User",foreign_key: "assigned_by"
  belongs_to :_assigned_to, class_name: "User",foreign_key: "assigned_to"
  belongs_to :_created_by, class_name: "User",foreign_key: "created_by"
  belongs_to :_updated_by, class_name: "User",foreign_key: "updated_by"
  
  scope :inactive,includes(:status).where("enquiry_statuses.name = 'deactivated'")
  scope :active, includes(:status).where("enquiry_statuses.name != 'deactivated'")
  
  scope :inactive,includes(:status).where("enquiry_statuses.name = 'deactivated'")
  
  scope :myactive, lambda{|user|
  if user.adm?
    includes(:status).where("enquiry_statuses.name != 'deactivated'")
  else
    includes(:status).where("enquiry_statuses.name != 'deactivated' AND enquiries.assigned_to = #{user.id}")
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
                  :todos_attributes,:contact_type_id
                  
  accepts_nested_attributes_for :programmes,:emails,:follow_ups,:notes,:todos, :allow_destroy => true
 
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


end
