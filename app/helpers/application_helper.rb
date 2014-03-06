module ApplicationHelper
  #basic li ul listing with vlsdet
  def li1(label,val,sizel,sizev,a = nil)
    html = ""    
    if val.kind_of?(Array)
      value = val[0]
      if (val[1].to_i == 0 || val[1].to_i == 97)
        cl = "red-wrong "
      elsif val[1].to_i == 98
        cl = "yellow-ok"
      elsif val[1].to_i == 99 
        cl = "green-right"
      else
        cl = "green-right" 
      end
      if (val[1] == 99 ||  val[1] ==  98 || val[1].to_i == 97)
        disp1 = "<small>#{val[2]}</small>"
      else
        disp1 = "<small>&nbsp;&nbsp;&nbsp; #{val[1]} #{val[2]}</small>"
      end
      
    else
      value = val
      cl ="padded"
    end
    if a.nil?
      disp = value
    else
      disp = best_in_place_if (can? :update,a),a,value.to_sym
    end  
    html += "<li>
             <div class=#{cl}>
             <label><#{sizel} class='light'>#{label.titleize}</#{sizel}></label>
             <#{sizev}  class=#{cl} >#{disp}  #{disp1}</#{sizev}> 
             </div>
             </li>"
    html.html_safe
  end
  
  def li_dt(col,ymsg,gmsg,obj)
   [((Date.today <= obj.send(col).to_date rescue col) ? [col,98,gmsg] : [col,99,ymsg]),col]
  end

  def prefer_countries(main,sub,values,data_values)

   html = ""

   html += "<div id=#{main}-#{sub} class='ms-selected-cols' data-items='#{data_values}'></div>"

   html += '<div class="form-group">
                      <div class="col-xs-10 col-xs-offset-2">'

   html +=  select_tag("#{main}[#{sub}][]",
           options_for_select(values),
                      {multiple: true,
                       class: "multiple-select"})

   html += '</div> </div>'

   html.html_safe

  end

  # bs -stands for bootstrap
  def bs(f,n,elem,lab,div,div2 = nil,div3 = nil, mand = nil)

    if lab[0].nil?
      l = n.is_a?(Array) ? n[0].to_s : n.to_s
    else
      l = lab[0]
    end

    if n.kind_of?(Array)
      n.last[:class] = n.last[:class].present? ? (n.last[:class] + " form-control") : "form-control"
      name = n
    else
      name = [n,class: "form-control"]
    end

    div2_head = div2.nil? ? "" : "<div class='col-xs-#{div2}'>"
    div2_tail = div2.nil? ? "" : "</div>"

    div3_head = div3.nil? ? "" : "<div class='#{div3}'>"
    div3_tail = div3.nil? ? "" : "</div>"

    (div3_head +
     div2_head +
    '<div class="form-group">' +
    f.label((name.kind_of?(Array) ? n[0].to_sym : n.to_sym),
              l.titleize,
              {class: "control-label col-xs-" + lab[1].to_s }) +
     "<div class=col-xs-#{div} >" +
     f.send(elem,*name) +
     "</div>" +
     "</div>" +
     div2_tail +
     div3_tail).html_safe

  end


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

  def go_create(obj,obj_name,id,name,disp = "none",box_cl = "frbox",tabindex = nil)

   prompt = "--" + obj_name.titleize + "--"
   model = obj_name.camelize.constantize
   main_div = obj_name + "_div"
   sel_cl = obj_name + "_select"
   a_id = "new_" + obj_name
   form_id = "new_" + obj_name + "_form"
   desc_id = obj_name + "_desc"
   add_desc_id = "add_" + obj_name + "_description"
   create_id = "create_" + obj_name

     html = ""

      html += "<div class='#{main_div} #{box_cl}' style='display:#{disp.to_s};'>"

      html += obj.label(obj_name.to_sym)
      html +="&nbsp;"
      html += obj.collection_select(id.to_sym,
                                    model.all,
                                    :id,
                                    name.to_sym,
                                    {:prompt => prompt },
                                    {:class => sel_cl,
                                     :tabindex => tabindex })
      if (can? :create, model)

          html += "<span id='#{a_id}' class='plus' onClick=showPopGoCreate('#{main_div}',event,this);>+</span>"

          html += "<div id=#{main_div} class='addNewPop' style='display:none;'>"
     html += "<div class='popuptitle'><span class='fl'>Add new #{obj_name.tr('_',' ')}</span><span class='Bpclose close-icon' lang=#{main_div} onClick=closePopGoCreate('#{main_div}',this);>x</span><div class='cl'></div></div>"

          html += "<br/><div class='fpbox'>"
          html += label_tag(name.to_sym)
          html += text_field_tag(name.to_sym)
          html += "</div>"

          html += "<div id='#{desc_id}' style='display:none;' class='fpbox'>"
          html += label_tag(:description)
          html += text_area_tag(:desc)
          html += "</div>"

          html += "<br/><span id='#{add_desc_id}'  class='btns fr' onClick=div_toggle(this,'div##{desc_id}');>Add description </span>"


          html += "<span lang='#{main_div}' class='Bpclose btnp fr' id='#{create_id}' onClick=submit_link(this,'div##{main_div}','#{obj_name}'); > Create #{obj_name.titleize} </span><div class='cl'></div><br/>"


          html += "</div>"

      end

      html += "</div>"


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

  def tym(a)
    a.strftime("%a, %F %R %p") rescue "Unknown"
  end

  def dat(a)
    a.strftime("%d-%m-%Y") rescue "Unknown"
  end

  def da_ty(a)
    a.strftime("%d-%m-%Y %H:%M") rescue "Unknown"
  end

  def iterate_tabs(hsh,model,opts = {})

    html = ""

    hsh.keys.each do |elem|
      if can? hsh[elem][1],hsh[elem][0].constantize
        #Shortening variable names
        e = elem.to_s.titleize
        html += "<li id='#{elem}'>"
        obj_id = instance_eval("@" + model).id

        options = {onclick: "action_partial('#{model.pluralize}',
                                               '#{e.downcase.tr(" ", "_")}',
                                               '#{obj_id}');",
                      data: {toggle: "tab"}}

        html += link_to(elem.to_s.titleize,"#",options.merge(opts))

        html += '</li>'
      end
    end

    html.html_safe
  end

  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
      fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render("shared/" + type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def li(label,value,grid_col_no,ul_class,label_no,value_no,label_align = "right",value_align = "left")
   html = ""
   html += "<div class=row><div class='col-xs-#{grid_col_no} text-left'><ul class=#{ul_class}><li>
            <div class='col-xs-#{label_no} text-#{label_align}'>
                <span class=light>
                  <small>#{label}</small>
                </span>
            </div>
            <div class='col-xs-#{value_no} text-#{value_align}'><small> #{value}</small></div>
                    </li>
                  </ul>
              </div>
            </div>"
            
   html.html_safe
  end
  
  def bulk_asso_update(label,select,obj,prompt,model,current_user_id,modal,modal_head,onclick,_id)
    html = ""
    
    ctnt = '<div class="row">
             <div class="col-md-10">
             <div class="col-md-offset-3">
             <form class="form-inline" role="form">' +
             label_tag(:user,label,{class: "col-md-3"}) +
               select_tag("#{select}#{_id}",
                          options_for_select(obj.constantize.order(:name).map{|i| [i.name.titleize,i.id]}),
               {prompt: prompt,
                class: "form-control hor-first col-md-4",
                        data: {model: model,
                        user_id: current_user_id}}) +
            '</form> </div></div></div>'

    render 'shared/modal',id: modal,
                         content: ctnt.html_safe,
                         header: modal_head,
                         button: "<button onclick=#{onclick}('#{_id}');>Change</button>"
                         
  end
  
  def markdown(text)
    
  end
                         
  
  
end
