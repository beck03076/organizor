module UserConfigsHelper

  def cols_to_display(model,values,data_values)#("enq_cols",enq_cols.map {|i| [i.titleize,i]}},user_enq_cols)
  
   html = ""
   
   html += "<div id=#{model} class='ms-selected-cols' data-cols='#{data_values}'></div>"
   
   html += '<div class="form-group">
                      <div class="col-md-12">'
   
   html +=  select_tag("user_config[#{model}][]",
           options_for_select(values),
                      {multiple: true,
                       class: "multiple-select"}) 
   
   html += '</div> </div>'
               
   html.html_safe
  
  end
  
end
