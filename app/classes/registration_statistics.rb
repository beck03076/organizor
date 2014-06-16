class RegistrationStatistics < CoreStatistics  

	def initialize(users,core)
		super(users,core)	
	end


	status_hash = {}
		ApplicationStatus.all.map {|i| status_hash[i.name] = i.id }

		status_hash.keys.each do |status|
		  define_method("#{status}") do |argument|
			argument.registrations.includes(:programmes).where(programmes: {app_status_id: status_hash[status]}).size
	    end
	end     

end