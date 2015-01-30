class AuditorObserver < ActiveRecord::Observer

  observe :enquiry,:note,:follow_up,:programme,
  :registration,:email,:application_status,
  :contact_type,:course_level,:course_subject,:doc_category,
  :english_level,:enquiry_status,:event_type,:exam_type,
  :qualification_name,:student_source,
  :todo_topic,:partner_type,:partner_group,
  :contract,:contract_doc_category,:person_type,
  :person,:commission_status,:branch,
  :smtp,:email_template,:allow_ip,
  :commission_claim_status,:progression_status,
  :processing_fee_type,:processing_fee_status,
  :document,:role,:required_doc, :required_doc_type

   def before_create(record)
     record.created_by = User.current.id unless User.current.nil?
   end
   
   def before_update(record)
     record.updated_by = User.current.id unless User.current.nil?
   end
  
end
