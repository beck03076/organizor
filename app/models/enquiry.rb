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
  
  belongs_to :student_source,:class_name => "EnquirySource",:foreign_key => "source_id"
  
  has_many :emails
  
  has_many :follow_ups
  
  has_many :todos
  
  has_many :notes,foreign_key: "sub_id"
  
  attr_accessible :emails_attributes,:programmes_attributes,
                  :assigned_by, :assigned_to, :created_by, 
                  :date_of_birth, :email1, :email2, 
                  :first_name, :gender, :mobile1, 
                  :mobile2, :score, :source_id, 
                  :surname, :updated_by,:country_ids,
                  :name,:address,:status_id,:country_id,
                  :follow_ups_attributes,:active,:notes_attributes,
                  :todos_attributes
                  
  accepts_nested_attributes_for :programmes,:emails,:follow_ups,:notes,:todos
 
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end

end
