class RegistrationsDatatable
  delegate :params, :h, :link_to, 
  :number_to_currency,:image_tag,:can?,
  :edit_registration_path,:check_box_tag,:current_user, to: :@view

  def initialize(view,cols,sFil)
    @view = view
    @cols = cols
    @sFilter = sFil
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Registration.mine(current_user).count,
      iTotalDisplayRecords: registrations.total_entries,
      aaData: data
    }
  end

private

  def data
    spc = "&nbsp;".html_safe
    dspc = "&nbsp; &nbsp;".html_safe
    
    final = []
    registrations.map do |reg|
       temp = []
       
       # setting the class so that the row be red for todays follow up
       fu_now_temp = reg.follow_up_date.split(",").map{|i|  (i.to_date == Date.today rescue nil) }.include?(true)
       # setting the class so that the row be red for this weeks follow up
       fu_week_temp = reg.follow_up_date.split(",").map{|i|((Date.today.at_beginning_of_week..Date.today.at_end_of_week).cover?(i.to_date) rescue nil) }.include?(true)
       
       v_fu_now = (fu_now_temp ? "fu_now" : "")
       v_fu_week = (fu_week_temp ? "fu_week" : "")
       
       temp << check_box_tag(:tr,reg.id,false,{data: {launch: "/registrations/#{reg.id}",
                                                      fu_now: v_fu_now,
                                                      fu_week: v_fu_week}}) 
       
       temp<<  link_to(image_tag("/images/icons/edi.png"),edit_registration_path(reg.id)) + spc +
               link_to(image_tag("/images/icons/del.png"),
                       "/registrations/#{reg.id}",
                       {:method => "delete",data: { confirm: 'Are you sure this delete?' }}) 

        @cols.map{|i|
          if i.is_a?(Array)
            temp << reg.send(i[1].to_s).try(i[2].to_s)
          else
            temp << reg.send(i.to_s).to_s
          end
        }
       
       final << temp
     end
    final

  end

  def registrations
    @registrations ||= fetch_registrations
  end
  
  def fetch_registrations
    set_cols
    sc = sort_column

    if !@sFilter.nil?      
      fet_stat= ApplicationStatus.find_by_name(@sFilter.titleize).try(:registrations)
      regs = fet_stat.nil? ? Registration.mine(current_user) : fet_stat.mine(current_user)
    end

    if sc.is_a?(Array)
      scs = set_asso(sc[1])
      join = "LEFT OUTER JOIN #{scs} asso ON asso.id = registrations.#{sc[0]}"
      regs = regs.joins(join).order("asso.#{sc[2]} #{sort_direction}")
    elsif !sc.nil?
      regs = regs.order("registrations.#{sc} #{sort_direction}")
    else
      regs = Registration.mine(current_user)
    end
   
    regs = regs.page(page).per_page(per_page)

    if params[:sSearch].present?
      res = @def_cols[params[:sSearch_0].to_sym] 
      if res.is_a?(Array)
        ress = set_asso(res[0])
        regs = regs.includes(res[0]).where("#{ress}.#{res[1].to_s} like :search", search: "%#{params[:sSearch]}%")
      elsif params[:sSearch_0].empty?
        regs = regs.where("#{@def_srch} like :search", search: "%#{params[:sSearch]}%") 
      else
        regs = regs.where("#{params[:sSearch_0]} like :search", search: "%#{params[:sSearch]}%")
      end
    elsif params[:sSearch_1].present?
      regs = regs.send(params[:sSearch_1])
    end 

    regs
    
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = [:id,:id] + (@cols - ["statuses"])
    p  columns[params[:iSortCol_0].to_i]
    columns[params[:iSortCol_0].to_i]
    
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
  
  def select_values
    Registration.all.map{|i| i.status}.uniq
  end
  
   
  def set_cols
    @def_cols = {:country_id => [:country_of_origin,:name],
     :qua_id => [:qualification,:name],
     :reg_source_id => [:student_source,:name],
     :sub_agent_id => [:sub_agent,:name],
     :assigned_to => [:_ass_to,:first_name],
     :assigned_by => [:_ass_by,:first_name],
     :created_by => [:_cre_by,:first_name],
     :updated_by => [:_upd_by,:first_name],
     :prof_eng_level_id => [:english_level,:name]}
     
     @def_srch = current_user.conf.def_reg_search_col
  end
  
   def set_asso(var)
    Registration.mine(current_user).reflect_on_association(var).klass.name.underscore.pluralize
  end
  
    
end
