class Institution < ActiveRecord::Base
  include CoreExtension

  validates_uniqueness_of :name, on: :create, message: " already exists as another institution, please check!" 
         
    
  mount_uploader :image, HumanImageUploader
  
  belongs_to :type, class_name: 'InstitutionType', foreign_key: 'type_id'
  belongs_to :group, class_name: 'InstitutionGroup', foreign_key: 'group_id'
  
  belongs_to :country,
             :class_name => "Country",
             :foreign_key => "country_id"
             
  belongs_to :city,
             :class_name => "City",
             :foreign_key => "city_id"
             
  has_many :people
  has_many :contracts
  
  
  
  has_many :programmes
  has_many :registrations, through: :programmes
  has_many :enquiries, through: :programmes
  
  has_and_belongs_to_many :emails 
  has_many :follow_ups
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Institution"'
  has_many :todos
  
  attr_accessible :city_id, :country_id, :created_by, 
  :name, :poc, :type_id, 
  :updated_by,:contracts_attributes,:people_attributes,
  :image,:remote_image_url,:email, 
  :website, :address_line1, :address_post_code, 
  :desc, :phone, :fax, 
  :address_line2,:notes_attributes,
  :assigned_to,:assigned_by,:prohibited_country_ids,:prohibited_region_ids,:permitted_country_ids,
  :permitted_region_ids,:group_id
  
  accepts_nested_attributes_for :contracts,:people,:notes,:allow_destroy => true
  
  def country_name
    self.country.name rescue "Unknown"
  end
     
  def city_name
    self.city.name rescue "Unknown"
  end
  
  def ins_type
    self.type.name rescue "Unknown"
  end
  
  def person_name
    self.person.first_name rescue "Unknown"
  end
  
  def tit
    self.name rescue "Title Unknown"
  end
  
  def my_enqs(user_id)
    self.enquiries.where(assigned_to: user_id)
  end
  
  def my_regs(user_id)
    self.registrations.where(assigned_to: user_id)
  end
  
  def my_peos(user_id)
    self.people.where(assigned_to: user_id)
  end
  
  
  
end
