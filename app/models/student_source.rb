class StudentSource < ActiveRecord::Base

  has_many :enquiries
  has_many :registrations
  has_many :programmes, through: :registrations

  belongs_to :contact_type
  
  attr_accessible :contact_type_id, :desc, :name

  def self.enquiries_registered(ids,direction)
    hsh = {}    
    joins(:enquiries)
    .where(enquiries: {id: ids})
    .group("student_source_id")
    .select("count(enquiries.id) as tcount,
    	     sum(case when enquiries.registered = 1 then 1 else 0 end) rcount,
    	     student_sources.name as sname,
             student_sources.id as sid")
    .order("rcount #{direction}")
    .map {|o| hsh[o.sname] = [o.tcount,o.rcount,o.sid]}
    hsh
  end 

  def self.total_fee_commission(ids,direction)
    hsh = {}    
    joins(programmes: [:fee])
    .where(registrations: {id: ids})
    .group("student_source_id")
    .select("sum(fees.tuition_fee_cents) as result1,
             sum(fees.commission_paid_cents) as result2,
             sum(fees.commission_amount_cents - fees.commission_paid_cents) as result3,
             student_sources.name as name,
             student_sources.id as id")
    .order("result2 #{direction}")
    .map {|o| hsh[o.name] = [o.result1,o.result2,o.result3,o.id]}
    hsh
  end 


end
