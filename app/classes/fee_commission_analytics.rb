module FeeCommissionAnalytics

  # =================
  # = Class Methods =
  # =================
  module ClassMethods 
    def fees_commission(data,conditions,core)
      new(data,"fees",core).fees_commission_compare(conditions)
    end
  end

  # ============
  # = Included =
  # ============
  def self.included(base)
    base.extend(ClassMethods)
  end	  

  def fees_commission_compare(conditions)
     # fetching all fees that qualify the conditions
    qualified_fees = qualify_period_size(Fee,conditions,false,false)
    # Complete output hash with name as key and fees and commission as values
    out = @model.total_fee_commission((qualified_fees.map &:id),@data)
    # readying table head in a separate array because it is being reused in charts categories
    table_head = ["#{@actual_core.titleize}","Fees Paid (Units)","Commission Received(Units)","Commission Pending(Units)"]
    # structuring the same for charts
    charts = [out.keys,charts_series(out,table_head)]
    # returning the output as hash    
    {table_header: table_head,
     ordered_output: out.first(conditions[:size].to_i),     
     page_header: "#{@title.titleize} Profitable #{@actual_core.titleize} <<size>>",
     charts: charts,
     chart_text: "Fees Paid, Commission Paid and Commission Pending",
     partial: "fee_commission",
     data_limit: 3
   }

  end

  def charts_series(out,th)
    result = []
    
    values = out.values
    th.slice(1..3).each_with_index do |i,index|
      hsh = {}
      hsh[:name] = i
      hsh[:data] = values.map{|i| i[index]}
      result << hsh
    end
    result
  end


end