class Branch < ActiveRecord::Base
  attr_accessible :created_by, :desc, :name, 
  :updated_by,:managed_by,:email,:phone,:fax,
  :address_line1,:address_line2,:address_post_code,
  :city_id,:country_id
  
  belongs_to :manager, foreign_key: "managed_by",class_name: "User"
  
  belongs_to :city
  belongs_to :country
  has_many :users
  has_many :enquiries
  has_many :registrations
  
  def self.ransackable_attributes(auth_object = nil)
    %w( name desc ) + _ransackers.keys
  end
  
end
