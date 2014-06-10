class Report 
  include ReportsData
  include RubyUtil
  include Generic
  attr_accessor :asso, :module, :mod

  def initialize(mod, heading = nil, asso = nil,split_param = nil, year = nil, month = nil)
  	@mod = mod
  	@module = mod[0..2]
  	@heading = heading  	
  	@asso = asso || "branch"
    @asso_name = get_asso_name(@asso)
  	@split_param = split_param || "def" 
    @year = year
    @month = month
  end

  def get_asso_name(i)
    if @asso == "user"
      "first_name"
    else
      "name"
    end

  end

  def get_fil_hash
    send("real_#{@module}_cols").slice(*send("def_#{@module}_fil"))
  end	

  def get_current_pie  	  	  	
  	@meta = "#{@mod.titleize} based on #{asso.titleize}"    

    temp = self.model(@asso).includes(@mod.to_sym).where(self.cond).all.map {|i| 
             s = i.send(@mod).size
             if s != 0
              [i.name,s] 
             end 
           }.compact
    if !temp.empty?
      sorted = temp.sort_by{|i| i[1] }
      sorted[0] = { name: sorted[0][0], y: sorted[0][1],sliced: true,selected: true}
      sorted
    else
      nil 
    end
  end  

  def get_current_bar(asso = "branch", split_param = 'def')
  	@asso = @asso || asso  	  	
  	@split_param = @split_param || split_param

    @split = send("#{@module}_bar_split",@split_param)
  	@meta = "#{@mod.titleize} based on #{asso.titleize}"
    temp = self.model(@asso).includes(@mod.to_sym).all.map {|i| 
             s = i.send(@mod).size
             if s != 0
              [i.send(@asso_name),s] 
             end 
           }.compact
    sorted = temp.sort_by{|i| i[1] }.reverse.take(10)
    category = sorted.map {|i| i [0] }

    temp_series = self.model(@mod.singularize).bar_chart(self.cond,@asso,@asso_name,@split[0],@split[1],@split[2])
    #  category usually looks like this, ["Australia", "New Zealand"] => the 2 elements data part pertains to this categories
    #  series usually looks like this, [{:name=>"Sent", :data=>[0, 0]}, {:name=>"Conditional Offer", :data=>[0, 0]}, 
    #                                   {:name=>"Unconditional Offer", :data=>[0, 0]}, 
    #                                   {:name=>"Pending", :data=>[0, 0]}, {:name=>"Joined", :data=>[1, 0]}, 
    #                                   {:name=>"Rejected", :data=>[0, 0]}, {:name=>"Defer", :data=>[2, 1]},     #                                   {:name=>"Sent To Documentation", :data=>[1, 0]}]
      
    series = form_chart_name_data(temp_series,category)
    # series looks like following,
    # [{:data=>[0, 0, 1, 0], :name=>"false"}, {:data=>[3, 0, 0, 0], :name=>"false"}, {:data=>[1, 0, 0, 0], :name=>"true"}, {:data=>[0, 2, 0, 0], :name=>"false"}, {:data=>[0, 0, 0, 1], :name=>"true"}]
    final_series = uniq_name_sum_data(series)
    # final_series looks like following,
    # [{:data=>[3, 2, 1, 0], :name=>"false"}, {:data=>[1, 0, 0, 1], :name=>"true"}]
    [category,final_series]	  
  end
  # this will be resolved for pie here, for bar, it will be sent to the bar_chart method 
  def cond
    cond = []
    cond << (@year.blank? ? "" : "YEAR(#{@mod}.created_at) = #{@year}")
    cond << (@month.blank? ? "" : "MONTH(#{@mod}.created_at) = #{@month}")
    cond.reject(&:empty?).join(" AND ")
  end

  def get_main_sel
  	arr = send("#{@module}_pie_val")
  	arr.map{|i| [i.titleize,i]}
  end

  def get_bar_split_sel
    arr = send("#{@module}_bar_split_val")    
  end 

end

