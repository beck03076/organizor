class EnquiryAnalytics
  include AnalyticsCommon

  def initialize(data,core)
    arr = data.split("-")    
    @data = arr[0]
    @title = arr[1]    
    @core = core
  end  

  def self.duration(data,conditions,core = "enquiries")
  	new(data,core).duration_days(conditions)
  end

  def duration_days(conditions)
  	# fetching filtered applications 
    filtered = qualify_period_size(order_nil_conversion_time,conditions,false)
     # returning the output as hash
    {table_header: ["name","channel","source","conversion_time","owner"],
     ordered_output: filtered,
     page_header: "Top <<size>> Enquiries That Took #{@title.titleize} Time to Register",
     link_id: :id,
     partial: "duration"}
  end

  def order_nil_conversion_time
    Enquiry.order("cast(conversion_time as unsigned) #{@data}").where("conversion_time IS NOT NULL")
  end
end