class Report 
  include ReportsHelper
  attr_accessor :asso, :module, :mod

  def initialize(mod, heading = nil, asso = nil)
  	@mod = mod
  	@module = mod[0..2]
  	@heading = heading  	
  	@asso = asso
  end

  def get_fil_hash
    send("real_#{@module}_cols").slice(*send("def_#{@module}_fil"))
  end	

  def get_current_pie(asso = "student_source")
  	@asso = @asso || asso  	  	
  	@meta = "#{@mod.titleize} based on #{asso.titleize}"
    temp = self.model(@asso).includes(:enquiries).all.map {|i| 
             s = i.send(@mod).size
             if s != 0
              [i.name,s] 
             end 
           }.compact
    sorted = temp.sort_by{|i| i[1] }
    sorted[0] = { name: sorted[0][0], y: sorted[0][1],sliced: true,selected: true}
    sorted
  end

  def get_pie_sel
  	arr = send("#{@module}_pie_val")
  	arr.map{|i| [i.titleize,i]}
  end

  def model(i)
    i.camelize.constantize
  end

end
