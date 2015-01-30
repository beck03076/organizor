class UserStatistics
	attr_accessor :all

	def initialize(users)
		@users = users
		@all = Hash.new { |h, k| h[k] = Hash.new }
	end

	def all_statistics	  
	  methods = (UserStatistics.instance_methods(false) - [:all,:all=,:all_statistics]).map &:to_s	
	  @users.each do |u|
	  	methods.each do |s|
	  		@all[s][u.id] = send(s,u)
	    end
	  end	 	  
	end

	def average_enquiry_conversion_days(u)
      u.enquiries.select("AVG(DATEDIFF(registered_at,created_at)) as ans").first.ans.to_f.round(2)  
    end


    def average_registration_conversion_days(u)
          list = (u.registrations.map &:conversion_time).compact  
	      return 0 if list.empty?   
	      (list.reduce(:+).to_f / list.size).round(2) 
    end

	%w(enquiries registrations).each do |action|
	  define_method("average_#{action.singularize}_response_time_in_hours") do |argument|
		  list = (argument.send(action).map &:response_time).compact  
	      return 0 if list.empty?   
	      (list.reduce(:+).to_f / list.size).round(2) 	
  	  end
    end 


    def average_task_completion_hours(u)
      u.tasks.select("AVG(TIMESTAMPDIFF(HOUR,created_at,done_at)) as ans").first.ans.to_f.round(2)    
    end

	def average_follow_up_completion_hours(u)
      u.follow_ups.select("AVG(TIMESTAMPDIFF(HOUR,created_at,followed_at)) as ans").first.ans.to_f.round(2)
    end

	def notes_written(u)
	  u.notes.size
	end

	def emails_sent(u)
	  u.emails.where(auto: false).size
	end

	def tasks_completed(u)
	  u.tasks.where(done: true).size
	end

    def tasks_pending(u)
	  u.tasks.where(done: false).size
	end

	def tasks_overdue(u)
	  u.tasks.where("DATE(duedate) < '#{Date.today.strftime("%Y-%m-%d")}'").size
	end

	def follow_ups_completed(u)
	  u.follow_ups.where(followed: true).size
	end

	def folow_ups_overdue(u)
	  u.follow_ups.where("DATE(ends_at) < '#{Date.today.strftime("%Y-%m-%d")}'").size
	end

	%w(enquiries registrations partners).each do |action|
	  define_method("#{action}_total_views") do |argument|
		Impression.where(user_id: argument.id,impressionable_type: action.singularize.camelize).size	  	
  	  end
    end 

    %w(enquiries registrations partners).each do |action|
	  define_method("#{action}_unique_views") do |argument|
		Impression.where(user_id: argument.id,impressionable_type: action.singularize.camelize).select("Distinct impressionable_id").size	  	
  	  end
    end 

    

end