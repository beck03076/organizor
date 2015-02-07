module TopMenuHelper
	
	def render_permitted_item(menu)
		if can? :read, menu[0].singularize.camelize.constantize
			html = ''
			html += "<li id='#{menu[0]}'>"
			html += link_to send(menu[0] + "_path") do
				        " <span class='glyphicon glyphicon-#{menu[1]}'></span>".html_safe + menu[0].titleize
              end
      html += "</li>"           
      html.html_safe                         
    end
  end


end