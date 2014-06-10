class RegistrationAnalytics
  include AnalyticsCommon



  def initialize(data,core)
    arr = data.split("-")    
    @data = arr[0]
    @title = arr[1]    
    @core = core
  end  



end