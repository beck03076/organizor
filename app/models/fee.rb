class Fee < ActiveRecord::Base
  attr_accessible :commission_amount_cents, :commission_percentage, :created_by, 
  :currency, :programme_id, :scholarship_cents, 
  :tuition_fee_cents, :updated_by,:first_payment_date,
  :invoice_date
  
  
  
  belongs_to :programme
  has_many :commissions, dependent: :destroy

  monetize :tuition_fee_cents
  monetize :scholarship_cents
  monetize :commission_amount_cents, :allow_nil => true
  
  
  ransacker :tuition_fee do |parent|
      Arel::Nodes::Division.new(parent.table[:tuition_fee_cents], 100 )
  end
  
  ransacker :commission_amount do |parent|
      Arel::Nodes::Division.new(parent.table[:commission_amount_cents], 100 )
  end
end
