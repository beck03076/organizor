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
    
    ("<div class='#{cl}' >" + f.label(name.kind_of?(Array) ? name[0].to_sym : name.to_sym ,l.titleize) + f.send(elem,*name) + "</div>").html_safe

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

  end
  
  def go_create(obj,obj_name,id,name,disp = "none")
   
   prompt = "--" + obj_name.titleize + "--"
   model = obj_name.camelize.constantize
   main_div = obj_name + "_div"
   sel_cl = obj_name + "_select"
   a_id = "new_" + obj_name
   form_id = "new_" + obj_name + "_form"
   desc_id = obj_name + "_desc"
   add_desc_id = "add_" + obj_name + "_description"
   create_id = "create_" + obj_name
   
      html = "<div class='#{main_div} fbox' style='display:#{disp.to_s};'>"
      
      html += obj.label(obj_name.to_sym)
      
      html += obj.collection_select(id.to_sym,
                                    model.all,
                                    :id,
                                    name.to_sym,
                                    {:prompt => prompt },
                                    {:class => sel_cl })
                                    
      html += "<span id='#{a_id}' onClick=showPop('popupBox1',event);>Add new </span>"

      html += "<div id='popupBox1' class='addNewPop' style='display:none;'>"
      html += "<h2>Add new #{obj_name.tr('_',' ')}</h2>"
      
      html += "<div class='field'>"
      html += label_tag(name.to_sym)
      html += text_field_tag(name.to_sym)
      html += "</div>"
      
      html += "<div id='#{desc_id}' style='display:none;'>"
      html += label_tag(:description)
      html += text_area_tag(:desc)
      html += "</div>"
      
      html += "<span id='#{add_desc_id}' onClick=div_toggle(this,'div##{desc_id}');>Add description </span>"

      html += "<span lang='popupBox1' class='Bpclose' >Create course </span>"
      
      html += "</div></div>"
      
      html.html_safe

  end

end
