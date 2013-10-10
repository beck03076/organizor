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
   
     html = "<style>
            .popuptitle{font-size:14px;font-weight:bold;color:#fff;padding:5px 10px 5px 10px;background:#2A88C8} 
            .addNewPop {padding: 0;border: 1px solid #ccc;box-shadow: 0 0 5px #ccc;border-radius: 5px;display: none;position: absolute;z-index: 100000000000;
background: #fff;overflow:hidden}
            .popupc{padding:3px 10px 2px 10px;text-align:left !important}
.popupc label{text-align:left !important;}
.popupc textarea,.popupc input{margin-left:0}
            .popupbtns{background:#F4F4F4;border-top:1px solid #E8E8E8;padding:5px}
            </style>"
   
      html += "<div class='#{main_div} fbox' style='display:#{disp.to_s};'>"
      
      html += obj.label(obj_name.to_sym)
      html +="&nbsp;"
      html += obj.collection_select(id.to_sym,
                                    model.all,
                                    :id,
                                    name.to_sym,
                                    {:prompt => prompt },
                                    {:class => sel_cl })
                                    

      html += "<span id='#{a_id}' class='plus' onClick=showPop('#{main_div}',event);>+</span>"

      html += "<div id=#{main_div} class='addNewPop' style='display:none;'>"
 html += "<div class='popuptitle'>Add new #{obj_name.tr('_',' ')}<span class='Bpclose close-icon' lang=#{main_div} onClick=closePop('#{main_div}');>x</span></div>"
      
      html += "<div class='fpbox'>"
      html += label_tag(name.to_sym)
      html += text_field_tag(name.to_sym)
      html += "</div>"
      
      html += "<div id='#{desc_id}' style='display:none;' class='fpbox'>"
      html += label_tag(:description)
      html += text_area_tag(:desc)
      html += "</div>"
      
      html += "<br/><span id='#{add_desc_id}'  class='btns fr' onClick=div_toggle(this,'div##{desc_id}');>Add description </span>"


      html += "<span lang='#{main_div}' class='Bpclose btnp fr' id='#{create_id}' onClick=submit_link(this,'div##{form_id}','#{obj_name}'); >Create course </span><div class='cl'></div><br/>"

      
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
