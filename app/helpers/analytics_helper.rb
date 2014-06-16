module AnalyticsHelper

  def analytics_listing(core,arr,text,link,chart = false)
  	html = ""
  	arr.each do |a|
  	  html += "<h4 class=border-b>#{chart ? '<small class="bright-tag glyphicon glyphicon-stats"></small>' : nil}"
  	  html += link_to "#{a[0]} #{text}","/analytics/#{core}/#{link}/#{a[1].downcase}-#{a[0].downcase}"
  	  html += "</h4>"
    end
    html.html_safe
  end

  def head_total(core)
  	html = ""
  	html += '<div class="row"><h4 class="bold-head">' + core.titleize 
  	html += " (<span class='bblue'>" + core.singularize.camelize.constantize.all.size.to_s + "</span>)"
	  html += '</h4> </div>'
  	html.html_safe
  end

  def filter_indicator(bar = '')    
    last_months = eval("@last_months" + bar)
    from = eval("@from" + bar)
    to = eval("@to" + bar)
      if [last_months, from, to].any? 
          html = ""
          html += '<div class="row padAll10 green-well text-center modal-tab"><h4 class="bold-subhead">Filtered By:</h4>     
                   <ul class="inline"><li>' +
                   (last_months.blank? ? nil : "#{last_months} month(s)").to_s + '
                   </li><li>' +
                   from.to_s +  
                   '</li><li>' + 
                   to.to_s  + 
                   '</li></ul></div>'
          html.html_safe         
      end 
  end

end
