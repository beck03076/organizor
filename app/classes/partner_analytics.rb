class PartnerAnalytics 
  include AnalyticsCommon
  include FeeCommissionAnalytics

  def self.applied_with(data,conditions,core = "partners")
    new(data,core).applied_compare(conditions)
  end

  def self.first_payment_duration(data,conditions,core = "partners")
    new(data,"fees").date_difference(conditions)
  end

  def initialize(data,core,actual_core = nil)
    arr = data.split("-")    
    @data = arr[0]
    @title = arr[1]
    @core = core
    @actual_core = actual_core || "partners"   
    @model = @actual_core.singularize.camelize.constantize
  end

  def date_difference(conditions)
    qualified_fee = qualify_period_size(Fee,conditions,false)
    out = fee_payment_duration_programme_ids(qualified_fee)
    programmes = fetch_ordered_records("Programme",[:partner,:ins_type,:course_level],out.keys,false)

    {table_header: ["Partners","Type","Course Level","First Payment In (Days)"],
     ordered_output: programmes,
     table_data: out,
     #charts: charts,
     page_header: "Partners <<size>> That Took #{@title.titleize} Time For the First Payment",
     #chart_text: "Applied Vs #{@data.titleize}",
     partial: "partners_first_payment"}
  end

  def fee_payment_duration_programme_ids(fees)
    hsh = {}
    fees.includes(:programme).map{|f| 
      next if f.invoice_date.nil? || f.first_payment_date.nil?
      hsh[f.programme.id] = (f.first_payment_date - f.invoice_date).to_i 
    }
    result = hsh.sort_by{|k,v| @data == "minus" ? -v : v } 
    result.to_h  
  end

  def applied_compare(conditions)
     # fetching all applications 
    total_ins = qualify_period_size(Programme.group(:partner_id),conditions)
    # fetching filtered applications 
    filtered = qualify_period_size(Programme.send(@data).group(:partner_id),conditions)
    # creating an hash with partner id as key and count of total,deferred applications as values
    out = hashify_ins_count(total_ins,filtered)   
    # sorting and bringing first the most deferred application partners
    ordered_ids = out.sort_by{|k,v| v[1] }.reverse.to_h.keys
    # fetching insitutions id,name and type strictly on the order got above
    partners = fetch_ordered_records("Partner",[:type],ordered_ids)
    # structuring the same for charts
    charts = charts_data(partners,out)
    # returning the output as hash
    {table_header: ["Partners","Type","Programmes Applied","Programmes #{@data.titleize}"],
     ordered_output: partners,
     table_data: out,
     charts: charts,
     page_header: "Top <<size>> Partners With #{@title.titleize} Conversion Rate",
     chart_text: "Applied Vs #{@data.titleize}",
     partial: "partners"}

  end

  def hashify_ins_count(total_ins,deferred)
    out = {}
    total_ins.each do |total|
      next if deferred[total[0]].nil?
      out[total[0]] = []
      out[total[0]] << total[1]
      out[total[0]] << deferred[total[0]]
    end
    out
  end

  def charts_data(partners,out)
    return [] if partners.blank?

  	categories = partners.map{|i| i[1] }.first(10)
  	partner_ids = partners.map{|i| i[0] }.first(10)
  	series_arr = []
  	[["Applied",0],[@data.titleize,1]].each do |bar|
  		series = {}
  		series[:name] = bar[0]
  		series[:data] = []
  		partner_ids.each do|partner_id|
  		  series[:data] << out[partner_id][bar[1]]
  		end  		
  		series_arr << series
  	end
  	[categories,series_arr]
  end


end