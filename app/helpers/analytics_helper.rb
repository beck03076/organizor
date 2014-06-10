module AnalyticsHelper

  def analytics_listing(core,arr,text,link)
  	html = ""
  	arr.each do |a|
  	  html += '<h4 class="border-b">'
  	  html += link_to "#{a[0]} #{text}","/analytics/#{core}/#{link}/#{a[1].downcase}-#{a[0].downcase}"
  	  html += '&nbsp;<small>asdfdsafdsafdsaf</small></h4>'
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

end
