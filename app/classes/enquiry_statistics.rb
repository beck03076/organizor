class EnquiryStatistics


		status_hash = {}
			EnquiryStatus.all.map {|i| status_hash[i.name] = i.id }
		
			status_hash.keys.each do |status|
			 define_method("#{status}_enquiries") do |argument|
				argument.enquiries.where(status_id: status_hash[status]).size
		     end
		end 
    

end