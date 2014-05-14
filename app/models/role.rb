class Role < ActiveRecord::Base
  
  before_save :set_old_permissions
  after_save :permissions_check
  
  has_many :users
  has_and_belongs_to_many :permissions
  attr_accessible :name,:permission_ids,:desc,
                  :created_by,:updated_by,:old_permissions
  accepts_nested_attributes_for :permissions
  
  def title_name
     self.name.titleize
  end
  
  def set_old_permissions
    @old_permissions = self.permissions.clone
  end
  
  def permissions_changed?
    (@old_permissions.map &:id) == (self.permissions.map &:id)
  end
  
  def set_default_permissions
    self.permissions << Permission.where(subject_class: "User", action: ["update","read"])
  end
  
  def change_users_permissions
    self.users.each do |u|
      u.permissions.delete_all
      u.permissions << self.permissions
    end
  end
  
  def permissions_check
    if permissions_changed? 
      set_default_permissions
      change_users_permissions
    end
  end
  
end
