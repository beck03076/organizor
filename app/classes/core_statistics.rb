class CoreStatistics  
	attr_accessor :all

	def initialize(users,core)
		@core = core
		@users = users
		@all = Hash.new { |h, k| h[k] = Hash.new }
		#send(@core)
	end

	def all_statistics	
      # => core_methods = EnquiryStatistics.instance_methods(false)
	  methods = ((CoreStatistics.instance_methods(false) - [:all,:all=,:all_statistics])).map &:to_s	
	  @users.each do |user|
	  	methods.each do |method|
	  		@all[method][user.id] = send(method,user)	  		
	    end
	  end	 	  

	end

	def assigned(u)
	  u.send(@core).size
	end

	def created(u)
	  u.send(@core).where(created_by: u.id).size
	end

=begin

    def registrations
		status_hash = {}
			ApplicationStatus.all.map {|i| status_hash[i.name] = i.id }

			status_hash.keys.each do |status|
			  define_method("#{status}") do |argument|
				argument.registrations.includes(:programmes).where(programmes: {app_status_id: status_hash[status]}).size
		    end
		end 
    end
=end
end