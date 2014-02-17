module CoreColumns
  # ===========
  # = Methods =
  # ===========
  
   def set_cols(model)
     if model == 'enquiry'
       @def_enq_cols = {:country_id => [:country_of_origin,:name],
                         :source_id => [:student_source,:name],
                         :contact_type_id => [:contact_type,:name],
                         :sub_agent_id => [:sub_agent,:name],
                         :assigned_to => [:_ass_to,:first_name],
                         :assigned_by => [:_ass_by,:first_name],
                         :created_by => [:_cre_by,:first_name],
                         :updated_by => [:_upd_by,:first_name],
                         :status_id => [:status,:name]}
     
     elsif model == 'registration'
       @def_reg_cols = {:country_id => [:country_of_origin,:name],
                         :qua_id => [:qualification,:name],
                         :reg_source_id => [:student_source,:name],
                         :sub_agent_id => [:sub_agent,:name],
                         :assigned_to => [:_ass_to,:first_name],
                         :assigned_by => [:_ass_by,:first_name],
                         :created_by => [:_cre_by,:first_name],
                         :updated_by => [:_upd_by,:first_name],
                         :prof_eng_level_id => [:english_level,:name],
                         :institution_id => [:institutions,:name]}
     
     elsif model == 'institution'
       @def_ins_cols = {type_id: [:type,:name],
                     group_id: [:group,:name],
                     country_id: [:country, :name],
                     city_id: [:city,:name]}
   
     elsif model == 'person'
       @def_per_cols =  {type_id: [:type,:name],
                     institution_id: [:institution,:name],
                     country_id: [:country, :name],
                     city_id: [:city,:name]}
     
     elsif model == 'programme'
       @def_pro_cols =  {level_id: [:course_level,:name],
                     institution_id: [:institution,:name],
                     country_id: [:country, :name],
                     city_id: [:city,:name],
                     registration_id: [:registration,:first_name],
                     }
     
     end
     
     
   end
  
end
