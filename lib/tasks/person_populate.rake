module PersonPopulate



	def start_person_populate	
		p "Started populating people"
		Person.order("RAND()").limit(50).all.each do |p|
			%w(emails tasks follow_ups notes).each do |a|
	          p "--#{a}--"	
			  p.send(a + '_count=',send('create_' + a + '_per_core',"people",p.id,"emails_people"))
			end 
	    end
	end

end