class AuditorObserver < ActiveRecord::Observer

  observe :enquiry,:note,:follow_up,:programme,:registration

   def before_create(record)
     record.created_by = User.current.id
   end
   
   def before_update(record)
     record.updated_by = User.current.id
   end
   
end
