require 'nokogiri'

class UserMailer < ActionMailer::Base
  default from: 'from@email.com'
  
  def send_email(obj,smtp_id)
  
    smtp = Smtp.find(smtp_id)    
      
    set_smtp(smtp)

    @body = inline_attachify(obj.body)
    p "*************"
    p obj.signature
    @sign = inline_attachify(obj.signature)     
    
    mail(:to => obj.to, 
         :subject => obj.subject,
         :cc => obj.cc,
         :bcc => obj.bcc,
         :from => smtp.name)
  end
  
  private
  
  def set_smtp(smtp)

    UserMailer.smtp_settings = {
      :address              => smtp.address,
      :port                 => smtp.port,
      :domain               => smtp.domain,
      :user_name            => smtp.user_name,
      :password             => smtp.password,
      :authentication       => smtp.authentication,
      :enable_starttls_auto => smtp.enable_starttls_auto
      }
      
  end

  def inline_attachify(ctnt)

    doc = Nokogiri::HTML(ctnt)

    doc.css('img').each do |img|
      src = img['src']
      fname = src.split("/").last
      fpath = Rails.root.to_s + '/public' + src.gsub(/\.\./,'')
      attachments.inline[fname] = File.read(fpath)
      img.set_attribute('src',attachments[fname].url)
    end

    doc.to_s

  end
  
  
end
