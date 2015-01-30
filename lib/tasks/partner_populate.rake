module PartnerPopulate

	def start_partner_populate	
		p "Started populating partners"
		Partner.order("RAND()").limit(50).all.each do |i|
			%w(emails todos follow_ups notes).each do |a|
			  p "--#{a}--"	
			  i.send(a + '_count=',send('create_' + a + '_per_core',"partners",i.id,"emails_partners"))
			end 
	    end
	end

end