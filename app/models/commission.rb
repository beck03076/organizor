class Commission < ActiveRecord::Base
  attr_accessible :created_by, :date_received, :paid,
  :remaining, :status_id, :updated_by, 
  :payment_id,:currency
  belongs_to :payment
  belongs_to :commission_status,:foreign_key => 'status_id'
  
  monetize :paid, :as => "paid_comm"
  monetize :remaining, :as => "rem_comm"
  
  
  def stat
    self.commission_status.name rescue nil
  end
  
  def stat_cl
    self.commission_status.name.downcase.tr(' ','_')  rescue nil
  end
  
end
