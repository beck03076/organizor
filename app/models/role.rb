class Role < ActiveRecord::Base
  audited
  before_save :default_values
  
  has_many :users
  has_and_belongs_to_many :permissions
  attr_accessible :name,:permission_ids,:desc,
                  :created_by,:updated_by
  accepts_nested_attributes_for :permissions
  
  def title_name
     self.name.titleize
  end
  
  
  def default_values
    self.permissions << Permission.where(subject_class: "User", action: ["update","read"])
  end
  
  
end
