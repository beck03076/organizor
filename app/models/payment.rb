class Payment < ActiveRecord::Base
  attr_accessible :amount, :commission, :programme_id, 
  :tuition_fee,:total_fee, :currency
  
  belongs_to :programme
  has_many :commissions
  
  monetize :amount, :as => "total_comm"
  monetize :tuition_fee, :as => "total_fee"
  
  before_save :convert  
  
  def current_comm
    (self.amount - (self.commissions.sum &:paid)) rescue nil
  end
  
  def all_comm
    (self.commissions.sum &:paid) rescue nil
  end
  
  def convert
    self.tuition_fee = self.tuition_fee * 100
    self.amount = self.amount * 100
  end
    

  
end
