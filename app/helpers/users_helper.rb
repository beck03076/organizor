module UsersHelper
	def skype_status(username)
		base_image = Net::HTTP.get(URI.parse("http://mystatus.skype.com/mediumicon/#{username}"))
		'<img src="data:image/png;base64,#{Base64.encode64(base_image)}" />'.html_safe
	end 
end
