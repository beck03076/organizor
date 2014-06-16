class ContactTypeAnalytics
  include AnalyticsCommon
  include EnquiriesRegisteredAnalytics
  include FeeCommissionAnalytics


  def initialize(data,core,actual_core=nil)
    arr = data.split("-")    
    @data = arr[0]
    @title = arr[1]
    @core = "enquiries"
    @actual_core = actual_core || "contact_type" 
    @model = @actual_core.singularize.camelize.constantize
  end 

  def self.enquiries_registered(data,conditions,core = "enquiries")
    new(data,core).enquiries_registered(conditions)
  end 

  def self.registrations_fees(data,conditions,core = "enquiries")
    new(data,core).enquiries_registered(conditions)
  end 


end