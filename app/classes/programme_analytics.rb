class ProgrammeAnalytics
  include AnalyticsCommon

  def self.duration(data,conditions,core)
  	new(data,core).duration_days(conditions)
  end

  def self.course_level_weight(data,conditions,core = "programmes")
    new(data,"programmes").course_level_weight(conditions)
  end

  def self.countries_processing_fees(data,conditions,core = "programmes")
    new(data,"programmes").countries_processing_fees(conditions)
  end

  def initialize(data,core)
  	arr = data.split("-")    
    @data = arr[0]
    @title = arr[1]    
    @core = core
    @model = @core.singularize.camelize.constantize
  end
  #==== Courselevel and Number of Programmes ================
  def countries_processing_fees(conditions)
    # fetching all fees that qualify the conditions
    qualified_programmes = qualify_period_size(Programme,conditions,false,false)
    # Complete output hash with name as key and fees and commission as values
    out = @model.countries_processing_fee((qualified_programmes.map &:id),@data)
    # structuring the same for charts
    #charts = charts_data(partners,out)
    # returning the output as hash
    {table_header: ["Countries","Total Processiong Fee (Units)"],
     ordered_output: out.first(conditions[:size].to_i),
     page_header: "#{@title.titleize} Processing Fee Earned Countries <<size>>",
     charts: out.to_a,
     chart_meta: ["Countries Vs Processing Fee","Chart Based on Processing Fee","Processing Fee Units"],   
     partial: "countries_processing_fee"}

  end  
  #==========================================================
  #==== Courselevel and Number of Programmes ================
  def course_level_weight(conditions)
    qualified_course_levels = qualify_period_size(Programme,conditions,false,false)
    out = @model.course_level_weight((qualified_course_levels.map &:id),@data)
    {table_header: ["Course Levels","Number of programmes"],
     ordered_output: out.first(conditions[:size].to_i),     
     page_header: "Course Levels <<size>> With #{@title.titleize} Number Of Programmes",
     charts: out.to_a,
     chart_meta: ["Course Levels Vs Programmes","Chart Based on Number of Programmes","Programmes"],     
     partial: "countries_processing_fee"}
  end

  def course_levels_programmes_count(course_levels)
    hsh = {}
    course_levels.map {|i| hsh[i.id] = i.programmes.size }
    result = hsh.sort_by{|k,v| @data == "minus" ? -v : v } 
    p "*****"
    p result
    result.to_h  
  end
  #==========================================================
  #==== Programmes and Time to Join =========================
  def duration_days(conditions)
  	# fetching filtered applications 
    filtered = qualify_period_size(order_nil_conversion_time,conditions,false)
     # returning the output as hash
    {table_header: ["registration_name","partner_name","course_level_name","conversion_time","owner"],
     ordered_output: filtered,
     page_header: "Top <<size>> Programmes That Took #{@title.titleize} Time to Join",
     #charts: charts,
     #chart_text: "Applied Vs #{@data.titleize}",
     link_id: :registration_id,
     partial: "programmes",
    }
  end

  def order_nil_conversion_time
    Programme.order("cast(conversion_time as unsigned) #{@data}").where("conversion_time IS NOT NULL")
  end
  #==========================================================
  def fetch_ordered_records(model,includable,ordered_ids,map = true)
    return [] if ordered_ids.blank?

    result = model.constantize.includes(includable).where(id: ordered_ids).order("FIELD(id,#{ordered_ids.join(",")})")

    return result if !map

    result.map{|i| [i.id,i.name,i.ins_type] }
  end
end