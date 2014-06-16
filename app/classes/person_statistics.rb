class PersonStatistics < CoreStatistics  

	def initialize(users,core)
		super(users,core)	
	end


	status_hash = {}
		PersonType.all.map {|i| status_hash[i.name] = i.id }

		status_hash.keys.each do |status|
		  define_method("#{status}") do |argument|
			argument.people.where(type_id: status_hash[status]).size
	    end
	end     

end