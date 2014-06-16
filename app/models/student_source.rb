class StudentSource < ActiveRecord::Base

  has_many :enquiries
  has_many :registrations

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


end
