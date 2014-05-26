class Report 
  include ReportsData
  attr_accessor :asso, :module, :mod

  def initialize(mod, heading = nil, asso = nil,split_param = nil)
  	@mod = mod
  	@module = mod[0..2]
  	@heading = heading  	
  	@asso = asso || "branch"
    @asso_name = get_asso_name(@asso)
  	@split_param = split_param || "def" 
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
    temp = self.model(@asso).includes(@mod.to_sym).all.map {|i| 
             s = i.send(@mod).size
             if s != 0
              [i.name,s] 
             end 
           }.compact
    sorted = temp.sort_by{|i| i[1] }
    sorted[0] = { name: sorted[0][0], y: sorted[0][1],sliced: true,selected: true}
    sorted
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
=begin
    
    p "********"
    p category
    @split[1].each do |s|            
      h = {}
      h[:name] = s[0]      
      h[:data] = category.map {|i|  self.model(@asso).send("find_by_#{@asso_name}",i).send(@mod.to_sym).send(@split[0],s[1]) } 
      
      series << h
    end
    :branch,{programmes: [:application_status]},:application_status,:name)
=end
    temp_series = self.model(@mod.singularize).bar_chart(@asso,@asso_name,@split[0],@split[1],@split[2])
    #  category usually looks like this, ["Australia", "New Zealand"] => the 2 elements data part pertains to this categories
    #  series usually looks like this, [{:name=>"Sent", :data=>[0, 0]}, {:name=>"Conditional Offer", :data=>[0, 0]}, 
    #                                   {:name=>"Unconditional Offer", :data=>[0, 0]}, 
    #                                   {:name=>"Pending", :data=>[0, 0]}, {:name=>"Joined", :data=>[1, 0]}, 
    #                                   {:name=>"Rejected", :data=>[0, 0]}, {:name=>"Defer", :data=>[2, 1]}, 
    #                                   {:name=>"Sent To Documentation", :data=>[1, 0]}]
      series = []
      temp_series.each do |i|
        h = {}  
        h[:data] = []
        category.each do |j|       

          if  j == i[0][0]
            h[:name] = i[0][1] 
            h[:data] << i[1]
          else
              h[:data] << 0
          end
        end
        series << h
      end

    [category,series]	  
  end

  def get_main_sel
  	arr = send("#{@module}_pie_val")
  	arr.map{|i| [i.titleize,i]}
  end

  def get_bar_split_sel
    arr = send("#{@module}_bar_split_val")    
  end

  def model(i)
    i.camelize.constantize
  end

end

