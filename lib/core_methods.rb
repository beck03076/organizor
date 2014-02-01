module CoreMethods
  # ===========
  # = Methods =
  # ===========
  
   def h_action_partial(name,obj_id,except_arr = [])
    
    model = name.camelize.constantize
    id = name + "_id"
    ids = name + "_ids"

    if @partial_name == "follow_up"
          #@d_f_u_days = current_user.conf.def_follow_up_days
          con = current_user.conf
          @follow_up = FollowUp.new(title: con.def_f_u_name, 
                                    desc: con.def_f_u_desc)

    elsif @partial_name == "note"
          @d_note = current_user.conf.def_note
          @note = Note.new(content: @d_note)
          
    elsif @partial_name == "todo"
          @todo = Todo.new
          
    elsif @partial_name == "timeline"
          @timelines = Timeline.where(m_name: "Enquiry", m_id: params[:id]).order("created_at DESC")
    end
    # next if block becase of separate renders
    if @partial_name == "email"
      mail_to_use = current_user.conf.def_enq_email.to_sym
      
      @subject = model.where(id: obj_id)
      @subject_ids = (@subject.map &:id).join(",")
      @email_to = ((@subject.map &mail_to_use) - ["",nil]).join(", ")
      render :partial => 'shared/email', :locals => {:e => Email.new(to: @email_to), 
                                                     :id => params[:e_id],
                                                     :obj => @subject,
                                                     :obj_ids => ids,
                                                     :obj_name => name }

    else
      # except register and deactivate other partials are shared, said are in enquiries
      out = (except_arr.include?(@partial_name) ? @partial_name : "shared/" + @partial_name)
      @obj = model.find(obj_id)
      render partial: out, locals:  {:e => Email.new,
                                     :id => obj_id,
                                     :obj => @obj,
                                     :obj_id => id,
                                     :obj_name => name}
    end
     
  end
      
  def basic_select(model,cond = true)
    model.where(cond).order(:name).map{|i| [i.name,i.id]}
  end
  
end
