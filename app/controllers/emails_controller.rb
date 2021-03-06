class EmailsController < ApplicationController
authorize_resource
skip_authorize_resource :only => [:show_hover,:bulk_email]

  def index
    set_url_params
    
    if current_user.adm? && @sent_by
      @emails = Email.includes(:_cre_by).where(created_by: @sent_by).order("created_at desc")
    else 
      @emails = current_user.emails.includes(:_cre_by)
    end

  end
  
  def new
    @email = Email.new
  end
    
  def create   
    m = params[:email][:model]
    m_id = (m + "_id").to_sym
    m_ids = (m + "_ids").to_sym

    
    params[:email].delete(:model)
    params[:email][m_ids] = params[:email][m_ids][0].split(',').map &:to_i
    
    @email = Email.new(params[:email])
    if @email.save      
#      UserMailer.delay(:retry => false).send_email(@email.id,@email.smtp_id)
       
       #If sending email to only one enquiry, trigger a notification.
       if params[:email][m_ids].size == 1
         receiver_id = m.camelize.constantize.find(params[:email][m_ids]).first.assigned_to rescue nil
       else 
         receiver_id = nil
       end
       
       tl(m.capitalize,params[:email][m_ids].join(","),"An email has been sent to this #{m}",
          params[:email][:subject],'email',receiver_id)
                       
      msg= "Email created successfully!"
    else
      msg= "Email create failed!"
    end
    redirect_to "/#{m.pluralize}/" + params[:email][m_ids][0].to_s
  end
  
  def bulk_email 
  
     set_url_params
     mail_to_use = current_user.conf.def_enq_email.to_sym
     @subject = @model.camelize.constantize.where(id: @model_ids.split(","))
     @email_ids = ((@subject.map &mail_to_use) - ["",nil]).join(", ")
     @subject_ids = (@subject.map &:id).join(",")
     @model_s = @model.downcase

     render :layout => false
     
  end
  
  def show_hover 
    @email = Email.find(params[:id])
    render partial: "emails/show_hover" 
  end
  
end
