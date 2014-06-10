module UsersHelper
	def skype_status(username)
		base_image = Net::HTTP.get(URI.parse("http://mystatus.skype.com/mediumicon/#{username}"))
		'<img src="data:image/png;base64,#{Base64.encode64(base_image)}" />'.html_safe
	end 

	def uimg(u)
    begin
	   image_tag((u.image? ? u.image_url : "/images/icons/user.png"),
                                         {width: "50",
                                          height: "50",
                                          class: "img-rounded",
                                          id: "usr_img" })
    rescue 
    ""
    end
  end 

    def head(obj,title,link_name,link_url)
    	html = ""
    	html += '<div class="row border-b"><div class="col-md-8"><h3 >' + title + '</h3></div>'
    	html += '<div class="col-xs-4 text-right">
                 <div class="form-group">' + 
                  (link_to link_name,link_url, {class: "btn btn-primary"}) +                  
                 '</div></div></div>'
        html.html_safe         
    end
end
