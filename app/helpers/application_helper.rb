module ApplicationHelper

  # f  object, name = attribute name, man = mandatory, lab = label name, cl_add = extra classes to add.
  def fs(f,name,elem,mand = nil,lab = nil,cl_add = nil)
  
    cl = "frbox "

    if lab.nil?
      l = name.is_a?(Array) ? name[0].to_s : name.to_s
    else
      l = lab
    end
    
    if !mand.nil?
      cl = "frbox mand"
      l = l + "*"
    end
    
    cl = cl + cl_add.to_s
    
    ("<div class='#{cl}' >" + f.label(name.kind_of?(Array) ? name[0].to_sym : name.to_sym ,l.titleize) + "&nbsp;"+f.send(elem,*name) + "</div>").html_safe

  end
  
  # f  object, name = attribute name, man = mandatory, lab = label name, cl_add = extra classes to add.
  def fbox(f,name,elem,mand = nil,lab = nil,cl_add = nil)
  
    cl = "fbox "

    if lab.nil?
      l = name.is_a?(Array) ? name[0].to_s : name.to_s
    else
      l = lab
    end
    
    if !mand.nil?
      cl = "fbox mand"
      l = l + "*"
    end
    
    cl = cl + cl_add.to_s
    
    ("<div class='#{cl}' >" + f.label(name.kind_of?(Array) ? name[0].to_sym : name.to_sym ,l.titleize) + f.send(elem,*name) + "</div>").html_safe

    ("<div class='#{cl}' >" + f.label(name.kind_of?(Array) ? name[0].to_sym : name.to_sym ,l.titleize) +  "&nbsp;" + f.send(elem,*name) + "</div>").html_safe

  end
  
  def go_create(obj,obj_name,id,name,disp = "none",box_cl = "frbox")
   
   prompt = "--" + obj_name.titleize + "--"
   model = obj_name.camelize.constantize
   main_div = obj_name + "_div"
   sel_cl = obj_name + "_select"
   a_id = "new_" + obj_name
   form_id = "new_" + obj_name + "_form"
   desc_id = obj_name + "_desc"
   add_desc_id = "add_" + obj_name + "_description"
   create_id = "create_" + obj_name
   
     
   
      html += "<div class='#{main_div} #{box_cl}' style='display:#{disp.to_s};'>"
      
      html += obj.label(obj_name.to_sym)
      html +="&nbsp;"
      html += obj.collection_select(id.to_sym,
                                    model.all,
                                    :id,
                                    name.to_sym,
                                    {:prompt => prompt },
                                    {:class => sel_cl })
                                    

      html += "<span id='#{a_id}' class='plus' onClick=showPopGoCreate('#{main_div}',event,this);>+</span>"

      html += "<div id=#{main_div} class='addNewPop' style='display:none;'>"
 html += "<div class='popuptitle'><span class='fl'>Add new #{obj_name.tr('_',' ')}</span><span class='Bpclose close-icon' lang=#{main_div} onClick=closePopGoCreate('#{main_div}',this);>x</span><div class='cl'></div></div>"
      
      html += "<div class='fpbox'>"
      html += label_tag(name.to_sym)
      html += text_field_tag(name.to_sym)
      html += "</div>"
      
      html += "<div id='#{desc_id}' style='display:none;' class='fpbox'>"
      html += label_tag(:description)
      html += text_area_tag(:desc)
      html += "</div>"
      
      html += "<br/><span id='#{add_desc_id}'  class='btns fr' onClick=div_toggle(this,'div##{desc_id}');>Add description </span>"


      html += "<span lang='#{main_div}' class='Bpclose btnp fr' id='#{create_id}' onClick=submit_link(this,'div##{main_div}','#{obj_name}'); >#{obj_name.titleize} </span><div class='cl'></div><br/>"

      
      html += "</div></div>"
      
      html.html_safe

  end
  
  def disp0(obj,method,default = "Unknown")
    obj.send(method) || default
  end
  
  def disp1(obj,method,var = "name",default = "Unknown")
    obj.send(method).try(var.to_sym) || default
  end
  
  def disp2(obj,method,var = "name",default = "Unknown")
    obj.send(method).reject(&:nil?).map(&var.to_sym).join(", ")
  end
  
  def disp3(obj,asso1,asso2,var = "name",default = "Unknown")
    obj.send(asso1).includes(asso2.to_sym).map{|i| i.send(asso2).try(var)}.join(", ") || default
  end
  

end
