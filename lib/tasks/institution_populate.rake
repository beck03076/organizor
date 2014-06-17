module InstitutionPopulate

	def start_institution_populate	
		p "Started populating institutions"
		Institution.all.each do |i|
			%w(emails todos follow_ups notes).each do |a|
			  p "--#{a}--"	
			  i.send(a + '_count=',send('create_' + a + '_per_core',"institutions",i.id,"emails_institutions"))
			end 
	    end
	end

end