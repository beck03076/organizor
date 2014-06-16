class ContactType < ActiveRecord::Base
  attr_accessible :desc, :name


  has_many :enquiries
  has_many :registrations
  has_many :student_sources
  has_many :programmes, through: :registrations

  def self.enquiries_registered(ids,direction)
    hsh = {}    
    joins(:enquiries)
    .where(enquiries: {id: ids})
    .group("contact_type_id")
    .select("count(enquiries.id) as tcount,
    	     sum(case when enquiries.registered = 1 then 1 else 0 end) rcount,
    	     contact_types.name as sname,
             contact_types.id as sid")
    .order("rcount #{direction}")
    .map {|o| hsh[o.sname] = [o.tcount,o.rcount,o.sid]}
    hsh
  end 

  def self.total_fee_commission(ids,direction)
    hsh = {}    
    joins(programmes: [:fee])
    .where(registrations: {id: ids})
    .group("contact_type_id")
    .select("sum(fees.tuition_fee_cents) as result1,
             sum(fees.commission_paid_cents) as result2,
             sum(fees.commission_amount_cents - fees.commission_paid_cents) as result3,
             contact_types.name as name,
             contact_types.id as id")
    .order("result2 #{direction}")
    .map {|o| hsh[o.name] = [o.result1,o.result2,o.result3,o.id]}
    hsh
  end 
  
end
