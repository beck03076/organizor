class Commission < ActiveRecord::Base
  attr_accessible :created_by, :date_received, :paid_cents,
  :remaining_cents, :status_id, :updated_by, 
  :payment_id,:currency,:fee_id

  belongs_to :fee  
  belongs_to :commission_status,:foreign_key => 'status_id'
  
  monetize :paid_cents, :allow_nil => true
  monetize :remaining_cents, :allow_nil => true

  after_create :increment_current_commission
  before_destroy :decrement_current_commission

  def increment_current_commission
    current = fee.commission_paid_cents.to_i + paid_cents
    fee.update_attribute(:commission_paid_cents,current)
  end

  def decrement_current_commission
    current = fee.commission_paid_cents.to_i - paid_cents
    fee.update_attribute(:commission_paid_cents,current)
  end
  
  def stat
    self.commission_status.name rescue nil
  end
  
  def stat_cl
    self.commission_status.name.downcase.tr(' ','_')  rescue nil
  end
  
  ransacker :paid do |parent|
      Arel::Nodes::Division.new(parent.table[:paid_cents], 100 )
  end
  
  ransacker :remaining do |parent|
      Arel::Nodes::Division.new(parent.table[:remaining_cents], 100 )
  end
  
end
