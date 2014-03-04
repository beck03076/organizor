class Commission < ActiveRecord::Base
  attr_accessible :created_by, :date_received, :paid_cents,
  :remaining_cents, :status_id, :updated_by, 
  :payment_id,:currency,:fee_id
  
  belongs_to :payment
  belongs_to :commission_status,:foreign_key => 'status_id'
  
  monetize :paid_cents, :allow_nil => true
  monetize :remaining_cents, :allow_nil => true
  
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
