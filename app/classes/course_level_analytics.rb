class CourseLevelAnalytics

  include AnalyticsCommon
  include FeeCommissionAnalytics

  def initialize(data,core,actual_core=nil)
    arr = data.split("-")    
    @data = arr[0]
    @title = arr[1]
    @core = core
    @actual_core = actual_core || "course_levels" 
    @model = @actual_core.singularize.camelize.constantize
  end  

end