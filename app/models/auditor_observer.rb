class AuditorObserver < ActiveRecord::Observer

  observe :enquiry,:note,:follow_up,:programme,
  :registration,:email,:programme_type,:application_status,
  :contact_type,:course_level,:course_subject,:doc_category,
  :english_level,:enquiry_status,:event_type,:exam_type,
  :qualification,:student_source,:sub_agent,:todo_status,
  :todo_topic,:institution_type,:institution_group,
  :contract,:contract_doc_category,:person_type,
  :person,:commission_status,:branch

   def before_create(record)
     record.created_by = User.current.id
   end
   
   def before_update(record)
     record.updated_by = User.current.id
   end
  
end
