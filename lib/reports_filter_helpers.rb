module ReportsFilterHelpers

    def figure_filter(i,f)
        html = ""

        if i[1] == 0 || i[1] == "datepicker"

          html+= h_text_date(i[0],i[0],i[1],f)

        elsif i[1].kind_of?(Array)

          html += h_fig_array(i[0],i[1],f)      

        elsif i[1].kind_of?(Hash)

          html += figure_range(i,f)

        end
        html.html_safe
      end  
      #=== deals with text fields and date picker fields =============
      def h_text_date(title,ph,what,f)
          html = ""
          ransack_field = (title.to_s + "_cont").to_sym
          ransack_html = "text_field"
          html += h_h_text_date(f,ransack_field,ransack_html,ph,what)
          html
      end

      def h_h_text_date(f,field,h,ph,date = nil)
        f.text_field field,
                  {class: "form-control #{date}",
                   placeholder: ph.to_s.titleize}
      end
      #===============================================================
      #=== deals with select, collection_select ======================
      def h_fig_array(title,arr,f)
          html = ""
          ransack_html = arr[0]
          tail = [{prompt: "-" + title.to_s.titleize + "-", include_blank: true},
                             {:class => "form-control"}]

          if ransack_html == "select"

            ransack_field = (arr[2].to_s + "_eq").to_sym
            html += f.select ransack_field, arr[1],*tail

          elsif ransack_html == "collection_select"

            ord = (arr[2].nil? ? :name : arr[2])
            ransack_field = (arr[3].to_s + "_eq").to_sym
            html += f.collection_select ransack_field,
                                arr[1].camelize.constantize.order(ord),
                                :id,
                                ord,
                                *tail      

          end
      end    
      #===============================================================
      #=== deals with associated, all fields==========================
      def figure_asso(i,f,q)
        html = ""
        l = []
        i[1].each do |c|

          html += "<div class='clear'></div>" 
          html += "<div class='#{c[:title]}' style='display: #{compare_q_cols(q,c[:cols],c[:table])};'>" 
          html += "<div class='clear'></div>"    
          html += "<h5 class='bold-subhead'> #{c[:title]}</h5>"

            c[:cols].each do |j|

              if j[1] == 0 || j[1] == "datepicker"

                html += "<div class='row'>"
                html += h_text_date(("#{c[:table]}_" + j[0].to_s).to_sym,j[0],j[1],f)
                html += "</div>"

              elsif j[1] == "datepicker>" ||  j[1] == "datepicker<" 

                html += h_range(f,j[0],j[1][-1],j[0])          

              elsif j[1] == "from<" ||  j[1] == "to>"

                html += h_range(f,j[0],j[1][-1],j[0],"")          

              elsif j[1].kind_of?(Array)
                
                html += "<div class='row'>"
                html += h_fig_array(("#{c[:table]}_" + j[0].to_s).to_sym,j[1],f)        
                html += "</div>"

              elsif j[1].kind_of?(Hash)

                html += figure_range(j,f)    

              end
            end
          html += '</div>'  
          l << ("<div class='w20'>" + link_to(c[:title],"#",{class: "", onclick: "$('.#{c[:title]}').slideToggle();"}) + "</div>").html_safe
        end
        [html.html_safe,l]
      end
      #===============================================================
      #=== Given input as one element of association hash, returns cols name ===
      def compare_q_cols(q,h,t)
        if !q.nil?
          arr = []  
          h.each do |i|  
            if i[1].kind_of?(Array)
              arr << i[1][3]
            elsif i[1].kind_of?(Hash)
              arr << i[1][:range_col].to_sym
              arr << (i[1][:cols].empty? ? nil : (i[1][:cols]).map {|i| i.to_sym})
            elsif i[1].kind_of?(String) || i[1].kind_of?(Integer)
              arr << ("#{t}_" + i[0].to_s).to_sym
            end
          end
          arr.compact

          weight = ((arr.compact) & (q.keys.map{|i| a = i.split("_"); a.pop; a.join("_").to_sym })).size
          out = (weight > 0 ? "" : "none")
          out
          p "****************"
          p arr.compact
          p (q.keys.map{|i| a = i.split("_"); a.pop; a.join("_").to_sym })
          p out
        else
          "none"
        end
      end
      #===============================================================
      #== deals with creating text fields for date with from and to ==
      def figure_range(i,f)
            html = "" 
            html += "<div class='clear'></div>"    
            html += "<h5 class='bold-subhead'> #{i[1][:title]}</h5>"


              i[1][:cols].each do |c|
                html += "<div class='row'>"
                html += f.text_field (c + "_cont").to_sym,{class: "form-control", placeholder: c.to_s.titleize} 
                html += "</div>"
              end
              
              d = i[1][:range_col]

              html += h_range(f,d,"<",i[1][:ph],i[1][:cl])
              html += h_range(f,d,">",i[1][:ph],i[1][:cl])
       

            html
      end
      #===============================================================
      #=== Forms text field with date picker based on dir ============
      def h_range(f,d,dir,ph,cl = "datepicker")
        html = ""
        if dir == ">"
          temp = "_lteq"
          ph1 = " To"
        elsif dir == "<"
          temp = "_gteq"
          ph1 = " From"
        end
     
        field = (d.to_s + temp).to_sym
        html += "<div class='row'>"
        html += f.text_field field,{class: "form-control #{cl}", placeholder: ph.to_s.titleize + ph1} 
        html += "</div>"
        html
      end
      #=== Finds filtered by what and displays above table ===========
      def filtered_by(q)    
        if q.blank?
          html = "<small>nothing</small>"
        elsif !q.except("s").blank? 
            html = ""
            q.except("s").each do |i|          
              arr = i[0].split("_")
              ope = arr.last
              col = arr[0..-2]
              col.delete("id")
              html += "<small class='yellow-ok'>" + col.join("_").titleize 
              html += "&nbsp;&nbsp;<small class='top'>" + link_to("X",
                              filter_reports_path(q: q.except(i[0]),
                                                  heading: @heading,
                                                  module: @module,
                                                  page: 1  ), 
                              {method: "post",
                               class: "grey-sm" }) + "</small>" 
              html += '</small>&nbsp;'  
            end        
        else
          html = "<small>nothing</small>"        
        end

        html.html_safe
      end
      #===============================================================
end