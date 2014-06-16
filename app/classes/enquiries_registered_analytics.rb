module EnquiriesRegisteredAnalytics

  def enquiries_registered(conditions)
     # fetching all fees that qualify the conditions
    qualified_enquiries = qualify_period_size(Enquiry,conditions,false,false)
    # Complete output hash with name as key and fees and commission as values
    out = @model.enquiries_registered((qualified_enquiries.map &:id),@data)
    # readying table head in a separate array because it is being reused in charts categories
    table_head = ["#{@actual_core.titleize}","Enquiries","Registered Enquiries"]
    # structuring the same for charts
    charts = [out.keys.first(10),charts_series(out,table_head)]
    # returning the output as hash    
    {table_header: table_head,
     ordered_output: out.first(conditions[:size].to_i),     
     page_header: "#{@title.titleize} Useful #{@actual_core.titleize} <<size>>",
     charts: charts,
     chart_text: "#{@actual_core.pluralize.titleize} - Enquiries Created Vs Enquiries Registered",
     partial: "fee_commission",
     data_limit: 2,
     no_link: true
    }
  end



  def charts_series(out,th)
    result = []
    
    values = out.values.first(10)
    th.slice(1..2).each_with_index do |i,index|
      hsh = {}
      hsh[:name] = i
      hsh[:data] = values.map{|i| i[index]}
      result << hsh
    end
    result
  end


end