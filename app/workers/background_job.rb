class BackgroundJob
  include Sidekiq::Worker

  def self.email(email_id)
    email_obj = Email.find(email_id)
    UserMailer.send_email(email_obj,email_obj.smtp_id).deliver
  end
end