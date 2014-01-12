module UserConfigsHelper

  def cols_to_display(model,values,data_values)#("enq_cols",enq_cols.map {|i| [i.titleize,i]}},user_enq_cols)
  
   html = ""
   
   html += "<div id='ms-selected-enq_cols' data-enq_cols='#{data_values}'></div>"
   
   html += '<div class="field" style="display:inline-block;">'
   
   html +=  select_tag("user_config[#{model}][]",
           options_for_select(values),
                      {multiple: true,
                              size: 2,
                 include_blank: false, 
                      id: model}) 
   
   html += '<br/> <div class="cl"></div> </div>'
               
   html.html_safe
  
  end
  
end
