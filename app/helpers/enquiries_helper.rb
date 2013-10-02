module EnquiriesHelper

  def disp0(obj,method,default = "Unknown")
    obj.send(method) || default
  end
  
  def disp1(obj,method,var = "name",default = "Unknown")
    obj.send(method).try(var.to_sym) || default
  end
  
  def disp2(obj,method,var = "name",default = "Unknown")
    obj.send(method).reject(&:nil?).map(&var.to_sym).join(", ")
  end
    
end
