class Fee < ActiveRecord::Base
  attr_accessible :commission_amount_cents, :commission_percentage, :created_by, 
  :currency, :programme_id, :scholarship_cents, 
  :tuition_fee_cents, :updated_by,:first_payment_date,
  :invoice_date,:cur_code
    
  belongs_to :programme
  has_many :commissions, dependent: :destroy
  has_one :registration, through: :programme
  
  monetize :tuition_fee_cents
  monetize :scholarship_cents
  monetize :commission_amount_cents, :allow_nil => true
  
  def cur_code=(r)
    self.currency = Currency.find_by_iso_numeric(r).code
  end
  
  def cur_code
    currency
  end
  
  
  ransacker :tuition_fee do |parent|
      Arel::Nodes::Division.new(parent.table[:tuition_fee_cents], 100 )
  end
  
  ransacker :commission_amount do |parent|
      Arel::Nodes::Division.new(parent.table[:commission_amount_cents], 100 )
  end

  ransacker :scholarship do |parent|
      Arel::Nodes::Division.new(parent.table[:scholarship_cents], 100 )
  end
end
