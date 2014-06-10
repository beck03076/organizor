class Audit < ActiveRecord::Base
 
  attr_accessible :auditable_id, :auditable_type,:action, :user_id, :comment, :created_at
  belongs_to :creator,foreign_key: :user_id,class_name: User

  def user
    User.find(self.user_id)
  end

  def self.notys(uid,lim = nil)
  	self.all(uid).order("created_at DESC").limit(lim)    
  end	
  
  def self.notys_badge(uid)
  	cnt = self.all(uid).where(checked: false).size
    out = cnt > 0 ? [cnt,""] : [0,"hide"]
    out   
  end

  def self.set_checked(aid)
    find(aid).update_attribute(:checked, true)
  end	

  def self.set_all_checked(uid)
  	self.all(uid).update_all(checked: true)
  end	

  def self.unchecked(uid)
  	self.all(uid).where(checked: false)
  end

  def self.all(uid) 
  	Audit.where(receiver_id: uid).where('user_id != ?',uid)
  end	

end
