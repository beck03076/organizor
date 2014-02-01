class Person < ActiveRecord::Base

  include CoreExtension
  
  validates :first_name, 
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another person, please check!" }
  
  audited
  
  attr_accessible :address_line1, :address_line2, :address_post_code, 
  :blogger, :city_id, :country_id, 
  :date_of_birth, :desc, :email, 
  :facebook, :first_name, :gender, 
  :gplus, :home_phone, :image, 
  :linkedin, :mobile, :skype, 
  :subject_class, :subject_id, :surname, 
  :twitter, :website, :work_phone,
  :created_by,:updated_by,:assigned_by,
  :assigned_to,:type_id,:notes_attributes,
  :job_title, :institution_id,:remote_image_url
  
  mount_uploader :image, HumanImageUploader
  
  belongs_to :country,
             :class_name => "Country",
             :foreign_key => "country_id"
             
  belongs_to :city,
             :class_name => "City",
             :foreign_key => "city_id"
  
  belongs_to :type, class_name: "PersonType",foreign_key: "type_id"
  
  belongs_to :institution
  
  has_and_belongs_to_many :emails 
  has_many :follow_ups
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Person"'
  has_many :todos
  
 
  accepts_nested_attributes_for :notes
  
 
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def country_name
    self.country.name rescue "Unknown"
  end
     
  def city_name
    self.city.name rescue "Unknown"
  end
  
  def person_type
    self.type.name rescue "Unknown"
  end
  
  def ins_name
    self.institution.name rescue "Unknown"
  end
  
end
