module EnquiryPopulate

	def contact_type_create
      h = {} 
      ContactType.includes(:student_sources).all.map {|i| h[i.id] = (i.student_sources.map &:id); }
      h
    end  

	def start_enquiry_populate
		    p "Started populating enquiries"

		    Enquiry.populate 1000 do |e|			      
			      e.first_name = Faker::Name.first_name
			      e.surname = Faker::Name.last_name
			      e.mobile1 = Faker::PhoneNumber.cell_phone
			      e.mobile2 = Faker::PhoneNumber.cell_phone
			      e.email1 = Faker::Internet.email
			      e.email2 = Faker::Internet.email
			      e.gender = @gender
			      e.date_of_birth  = @dob
			      e.score = @score
			      e.assigned_to = @user
			      e.created_by = @user
			      e.assigned_by = @user
			      e.created_at = @created
			      e.country_id = @country
			      e.status_id = @enquiry_status
			      e.address = Faker::Lorem.sentence      
			      e.active = @bool     
			      e.registered = !e.active
			      if e.registered
			      	e.registered_at = e.created_at + 1.week
			      	e.registered_by = e.assigned_to
			      end
			      e.branch_id = @branch
			      e.assigned_at = @created      
			      e.direct = @bool
			      if e.direct        
			        e.contact_type_id = @contact_type.keys
			        e.student_source_id = @contact_type[e.contact_type_id]
			      else
			        e.sub_agent_id = @sub_agent
			      end

			      PreferredCountry.populate 1..5 do |p_country|
			        p_country.country_id = @country
			        p_country.enquiry_id = e.id        
			        p_country.created_at = @created
			      end    

			      Programme.populate 1..4 do |prog|
			        prog.type_id = @programme_type
			        prog.institution_id = @institution
			        prog.level_id = @course_level
			        start = 1.year.from_now..4.years.from_now
			        prog.start_date = start
			        prog.end_date = prog.start_date + 3.years
			        prog.enquiry_id = e.id
			        prog.created_at = @created
			        prog.course_subject_text = Faker::Lorem.word
			        prog.created_by = @user
			        prog.notes_count = 0
			      end

			      %w(emails todos follow_ups notes).each do |a|
			      	p "--#{a}--"	
			        e.send(a + '_count=',send('create_' + a + '_per_core',"enquiries",e.id,"emails_enquiries"))
			      end 
		    end
	end

end