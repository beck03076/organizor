class UserMailer < ActionMailer::Base
  default from: 'from@email.com'
  
  def send_email(id,smtp_id)
  
    smtp = Smtp.find(smtp_id)
    obj = Email.find(id)
      
    set_smtp(smtp)
    
    @body = obj.body
    
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
  
  
end
