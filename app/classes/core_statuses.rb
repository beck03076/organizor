class CoreStatuses

	def self.enquiries
		
		status_hash = {}
		EnquiryStatus.all.map {|i| status_hash[i.name] = i.id }
	
		status_hash.keys.each do |status|
		 define_singleton_method("#{status}_enquiries") do |argument|
			argument.enquiries.where(status_id: status_hash[status]).size
	  	  end
	    end 
	end

		

    def registrations
		status_hash = {}
			ApplicationStatus.all.map {|i| status_hash[i.name] = i.id }

			status_hash.keys.each do |status|
			  define_method("#{status}") do |argument|
				argument.registrations.includes(:programmes).where(programmes: {app_status_id: status_hash[status]}).size
		    end
		end 
    end
=begin
	def institutions
		status_hash = {}
		InstitutionType.all.map {|i| status_hash[i.name] = i.id }
		status_hash.keys.each do |status|
		  define_method("#{status}") do |argument|
			argument.institutions.where(type_id: status_hash[status]).size
	  	  end
	    end 
	end

	def people
		status_hash = {}
		PersonType.all.map {|i| status_hash[i.name] = i.id }
		status_hash.keys.each do |status|
		  define_method("#{status}") do |argument|
			argument.people.where(type_id: status_hash[status]).size
	  	  end
	    end 
	end
=end
end