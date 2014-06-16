class Analytics

	attr_accessor :out

	def initialize(core,core_method,core_params,size = nil,from = nil,to = nil, last_months = nil)
	  @conditions = {size: size,last_months: last_months,from: from, to: to}
	  @core = core
	  @core_method = core_method
	  @core_params = core_params
	  @out = []
	end

    def all_analytics
    	p @core
		clazz = (@core.singularize + "_analytics").camelize.constantize    	
		@out = clazz.send(@core_method,@core_params,@conditions,@core)   	
    end


end  