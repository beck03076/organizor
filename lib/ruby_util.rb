module RubyUtil

  def form_chart_name_data(arr,cat)
  	series = []
  	arr.each do |i|
        h = {}  
        h[:data] = []
        cat.each do |j|       

          if  j == i[0][0]
            h[:name] = i[0][1].to_s
            h[:data] << i[1]
          else
              h[:data] << 0
          end
        end
        series << h
      end
    series
  end

  def uniq_name_sum_data(arr)	
     arr.group_by{|h| 
                     h[:name]}.values.map{|i| 
                     i.size > 1 ?  {:data => i.map {|i| 
                     i[:data]}.transpose.map {|x| 
                      x.reduce(:+)},:name => i.first[:name]} : i  }.flatten.sort_by{|i| i[:name]}
  end
end                      