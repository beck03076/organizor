class EmailsController < ApplicationController
authorize_resource
skip_authorize_resource :only => [:show_hover,:bulk_email]

  def filter
    set_url_params
    
    @sent_by = @sent_by.blank? ? nil : @sent_by
    @sent_to = @sent_to.blank? ? nil : @sent_to
    who = @sent_by || @sent_to
    
    ids = params[who.to_sym].values.reject(&:empty?).join(",")
    
    if (!@from_date.blank? && !@to_date.blank?)
      cond = "#{who.pluralize}.id in (#{ids}) AND date(emails.created_at) BETWEEN '#{@from_date}' AND '#{@to_date}'"
    else
      cond = { id: ids}
    end
    
    @emails = (who.camelize.constantize.includes(:emails).where(cond).map &:emails).flatten
    
  end

  def index
    @emails = current_user.emails.includes(:_cre_by)
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
     
     # the following 2 lines sets the email as email1 or 2 based on settings and if nothing is set, it rescues with email
     default = "def_" + @model[0..2].downcase + "_email"
     mail_to_use = current_user.conf.send(default).to_sym rescue "email"
     
     @subject = @model.camelize.constantize.where(id: @model_ids.split(","))
     @email_ids = ((@subject.map &mail_to_use.to_sym) - ["",nil]).join(", ")
     @subject_ids = (@subject.map &:id).join(",")
     @model_s = @model.downcase

     render :layout => false
     
  end
  
  def show 
    @email = Email.find(params[:id])
  end

    # DELETE /email_templates/1
  # DELETE /email_templates/1.json
  def destroy
    @email = Email.find(params[:id])
    @email.destroy
  end
  
end
