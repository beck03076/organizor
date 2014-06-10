class Institution < ActiveRecord::Base
  include CoreModel

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

  
  
  attr_accessible :city_id, :country_id, :created_by, 
  :name, :poc, :type_id, 
  :updated_by,:contracts_attributes,:people_attributes,
  :image,:remote_image_url,:email, 
  :website, :address_line1, :address_post_code, 
  :desc, :phone, :fax, 
  :address_line2,:assigned_to,:assigned_by,:prohibited_country_ids,:prohibited_region_ids,
  :permitted_country_ids,:permitted_region_ids,:group_id,:assigned_at
  
  accepts_nested_attributes_for :contracts,:people,:allow_destroy => true
  
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

  def self.total_fee_commission(ids,direction)
    hsh = {}    
    joins(programmes: [:fee])
    .where(fees: {id: ids})
    .group("institution_id")
    .select("sum(fees.tuition_fee_cents) as result1,
             sum(fees.commission_paid_cents) as result2,
             sum(fees.commission_amount_cents - fees.commission_paid_cents) as result3,
             institutions.name as name,
             institutions.id as id")
    .order("result2 #{direction}")
    .map {|o| hsh[o.name] = [o.result1,o.result2,o.result3,o.id]}
    hsh
  end

  def self.total_commission_paid_cents(ids)
    where(id: ids).joins(programmes: [:fee]).group("institution_id").sum("fees.commission_paid_cents")
  end 
  
end
