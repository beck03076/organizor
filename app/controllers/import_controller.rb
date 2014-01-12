class ImportController < ApplicationController
 
   require 'net/http'
   require 'net/https'
   require 'uri'
   
  def start
   return redirect_to "/auth/google_oauth2"
  end
  
  def contacts
  p "************8"
  
  @title = "Google Authetication"
          token = params[:code]
          client_id = "412836660909.apps.googleusercontent.com"
          client_secret = "9THYqMEcuFRQtuCObnn148cQ"
          uri = URI('https://accounts.google.com/o/oauth2/token')
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Post.new(uri.request_uri)

          request.set_form_data('code' => token, 'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => 'http://127.0.0.1:3000/auth/google_oauth2/callback', 'grant_type' => 'authorization_code')
          request.content_type = 'application/x-www-form-urlencoded'
          response = http.request(request)
          response.code
          access_keys = ActiveSupport::JSON.decode(response.body)

          uri = URI.parse("https://www.google.com/m8/feeds/contacts/default/full?oauth_token="+access_keys['access_token'].to_s+"&max-results=50000&alt=json")

          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)
         
          
          p "********************"
          p response
=begin
    @contacts = request.env['omnicontacts.contacts']

      @contacts.each do |c|
      p "****************"
      p c[:first_name]
      p c[:last_name]
      p c[:phone_number]
      p "&&&&&&&&&&&&&&&&&&&&&&"
      p c
      p "*********************"
      

        c[:city_id] = City.find_by_name(c[:city]).id rescue nil
        c[:country_id] = Country.find_by_name(c[:country]).id rescue nil
        
        Person.create!(email: c[:email],
                       first_name: c[:first_name],
                       surname: c[:last_name],
                       address_line1: c[:address_1],
                       address_line2: c[:address_2],
                       city_id: c[:city_id],
                       country_id: c[:country_id],
                       address_post_code: c[:postcode],
                       mobile: c[:phone_number],
                       gender: c[:gender])

      end
      
    redirect_to "/people"
=end
  end

  def events
  end

  def tasks
  end

end
