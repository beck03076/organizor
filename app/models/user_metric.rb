class UserMetric 
  include Generic	
  attr_accessor :all
  
  def initialize(users,mod)
  	@users = users
  	@mod = mod
  	@all = {} 	
  end

  def statistics      	
    obj = UserStatistics.new(@users)
    obj.all_statistics        
    @all[:statistics] = obj.all
  end

  %w(enquiries registrations institutions people).each do |action|
      define_method("#{action}") do 
        obj = CoreStatistics.new(@users,action)
        #obj.core = action      
        obj.all_statistics    
        @all[action.to_sym] = obj.all       
      end
    end

end