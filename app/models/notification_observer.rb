class NotificationObserver < ActiveRecord::Observer
 # please note the group assign notification is done in the controller side
  observe :enquiry,:registration,:todo,:follow_up,:programme,:note,:email
   
   def after_save(record)
     
    if record.class.name == "Note"
    
       if record.sub_class == "Programme"
         ass_to = record.sub_class.constantize.find(record.sub_id).registration.assigned_to
         msg = "A note has been created for your registration"
       else
         ass_to = record.sub_class.constantize.find(record.sub_id).assigned_to
         msg = "Note has been created for a #{record.sub_class} assigned to you"
       end
       
       PrivatePub.publish_to("/notify/" + ass_to.to_s, 
                          message: msg,
                          ass_by: nil)
                          
     elsif (record.assigned_to != record.assigned_by rescue false)
       # this condition is added to ignore updating done field of todo to be notified
       if (record.class.name == "Todo" && !record.done.nil?)
         nil
       else
         PrivatePub.publish_to("/notify/" + record.assigned_to.to_s, 
                          message: "#{record.class.name} has been re-assigned/changed",
                          ass_by: record.assigned_by)
       end
     end
     
   end
=begin   
    if record.class.name == "Programme"
       
       ass_to = record.registration.assigned_to
       PrivatePub.publish_to("/notify/" + ass_to.to_s, 
                          message: "A programme is created/updated for your registration")
       
     els
=end
end
