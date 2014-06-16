class CoreStatistics  
	attr_accessor :all

	def initialize(users,core)
		@core = core
		@users = users
		@all = Hash.new { |h, k| h[k] = Hash.new }
		#send(@core)
	end

	def all_statistics(klazz)
      core_methods = klazz.instance_methods(false) + CoreStatistics.instance_methods(false) - [:all,:all=,:all_statistics]
      filtered_methods = (core_methods.map &:to_s).sort 
	  
	  @users.each do |user|
	  	filtered_methods.each do |method|
	  		p "&&&"
	  		p method
	  		@all[method][user.id] = send(method,user)	  		
	    end
	  end	 	  

	end

	def Assigned(u)
	  u.send(@core).size
	end

	def Created(u)
	  u.send(@core).where(created_by: u.id).size
	end
end