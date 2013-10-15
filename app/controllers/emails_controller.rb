class EmailsController < ApplicationController

  def save_send    
    m = params[:email][:model]
    m_id = (m + "_id").to_sym
    m_ids = (m + "_ids").to_sym
    params[:email].delete(:model)
    params[:email][m_ids] = params[:email][m_ids][0].split(',').map &:to_i
    
    @email = Email.new(params[:email])
    if @email.save      
#      UserMailer.delay(:retry => false).send_email(@email.id,@email.smtp_id)
      
       Timeline.create!(user_id: current_user.id,
                       user_name: current_user.first_name.to_s + ' ' + current_user.surname.to_s,
                       m_name: m.capitalize,
                       m_id: params[:email][m_ids].join(","),
                       created_at: Time.now,
                       desc: "An email has been sent to this #{m}",
                       comment: params[:email][:subject],
                       action: 'email')
                       
      msg= "Email created successfully!"
    else
      msg= "Email create failed!"
    end
    redirect_to "/#{m.pluralize}/" + params[:email][m_id].to_s
  end
  
  def template_create
  end
  
  def new
    EmailTemplate.create(params)
    render :nothing
  end
  
  def bulk_email 
  
     set_url_params
     mail_to_use = UserConfig.find(current_user.id).def_enq_email.to_sym
     @subject = @model.camelize.constantize.where(id: @model_ids.split(","))
     @email_ids = ((@subject.map &mail_to_use) - ["",nil]).join(", ")
     @subject_ids = (@subject.map &:id).join(",")
     @model_s = @model.downcase

     render :layout => false
     
  end
  
end
