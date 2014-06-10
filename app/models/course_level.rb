class CourseLevel < ActiveRecord::Base
  has_many :programmes, foreign_key: "level_id"

  attr_accessible :created_by, :desc, :name, :updated_by

   def self.total_fee_commission(ids,direction)
    hsh = {}    
    joins(programmes: [:fee])
    .where(fees: {id: ids})
    .group("level_id")
    .select("sum(fees.tuition_fee_cents) as result1,
             sum(fees.commission_paid_cents) as result2,
             sum(fees.commission_amount_cents - fees.commission_paid_cents) as result3,
             course_levels.name as name,
             course_levels.id as id")
    .order("result2 #{direction}")
    .map {|o| hsh[o.name] = [o.result1,o.result2,o.result3,o.id]}
    hsh
  end 
  
  
end
