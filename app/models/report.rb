class Report 
  include ReportsData
  attr_accessor :asso, :module, :mod

  def initialize(mod, heading = nil, asso = nil,split_param = nil)
  	@mod = mod
  	@module = mod[0..2]
  	@heading = heading  	
  	@asso = asso || "branch"
  	@split_param = split_param || "sco" 
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

  def get_current_bar(asso = "contact_type", split_param = 'sco')
  	@asso = @asso || asso  	  	
  	@split_param = @split_param || split_param
    @split = send("#{@module}_bar_split",@split_param)
  	@meta = "#{@mod.titleize} based on #{asso.titleize}"
    temp = self.model(@asso).includes(@mod.to_sym).all.map {|i| 
             s = i.send(@mod).size
             if s != 0
              [i.name,s] 
             end 
           }.compact
    sorted = temp.sort_by{|i| i[1] }.reverse.take(10)
    category = sorted.map {|i| i [0] }
    series = []    
    @split[1].each do |s|            
      h = {}
      h[:name] = s[0]
      h[:data] = category.map {|i|  self.model(@asso).find_by_name(i).send(@mod.to_sym).send(@split[0],s[1]) } 
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

