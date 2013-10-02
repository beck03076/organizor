class EmailsController < ApplicationController

  def save_send
    @email = Email.new(params[:email])
    
    if @email.save      
      UserMailer.delay(:retry => false).send_email(@email.id,@email.smtp_id)
      
       Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: "Enquiry",
                       m_id: params[:email][:enquiry_id],
                       created_at: Time.now,
                       desc: 'An email has been sent to this enquiry',
                       comment: params[:email][:subject],
                       action: 'email')
                       
      msg= "Email created successfully!"
    else
      msg= "Email create failed!"
    end
    redirect_to '/enquiries/' + params[:email][:enquiry_id].to_s
  end
  
  def template_create
  end
  
  def new
    EmailTemplate.create(params)
    render :nothing
  end
  
end
