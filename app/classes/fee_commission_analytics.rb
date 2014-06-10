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
    # structuring the same for charts
    #charts = charts_data(institutions,out)
    # returning the output as hash
    {table_header: ["#{@actual_core.titleize}","Total Fees Paid (Units)","Total Commission Received(Units)","Total Commission Pending(Units)"],
     ordered_output: out.first(conditions[:size].to_i),
     #charts: charts,
     page_header: "#{@title.titleize} Profitable #{@actual_core.titleize} <<size>>",
     #chart_text: "Applied Vs #{@data.titleize}",
     partial: "fee_commission"}

  end


end