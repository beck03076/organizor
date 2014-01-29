class EnquiriesDatatable < DeviseController
  delegate :params, :h, :link_to, 
  :number_to_currency,:image_tag,
  :can?,:edit_enquiry_path,:check_box_tag, 
  :current_user,to: :@view

  def initialize(view,cols,sFil)
    @view = view
    @cols = cols 
    @sFilter = sFil
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Enquiry.myactive(current_user).count,
      iTotalDisplayRecords: enquiries.total_entries,
      aaData: data
    }
  end

private

  def data  
    spc = "&nbsp;".html_safe
    dspc = "&nbsp; &nbsp;".html_safe
    
    final = []
    
    enquiries.map do |enq|
       temp = []


       # setting the class so that the row be green for registered enqs
       reg = (enq.registered ? "enq_reg" : "")
       # setting the class so that the row be red for todays follow up
       fu_now_temp = enq.f_ups.map{|i|  (i.to_date == Date.today rescue nil) }.include?(true) rescue nil
       # setting the class so that the row be red for this weeks follow up
       fu_week_temp = enq.f_ups.map{|i|((Date.today.at_beginning_of_week..Date.today.at_end_of_week).cover?(i.to_date) rescue nil) }.include?(true) rescue nil
       
       v_fu_now = (fu_now_temp ? "fu_now" : "")
       v_fu_week = (fu_week_temp ? "fu_week" : "")
       
       if enq.score > 7
        like = image_tag("/images/icons/green.png")
       elsif enq.score < 3
        like = image_tag("/images/icons/red.png")
       else
        like = image_tag("/images/icons/yellow.png")
       end
       

       
       temp << check_box_tag(:tr,enq.id,false,{data: {launch: "/enquiries/#{enq.id}",
                                                      registered: reg,
                                                      fu_now: v_fu_now,
                                                      fu_week: v_fu_week,
                                                       }})

        @cols.map{|i|
          if i.is_a?(Array)
            temp << enq.send(i[1]).try(i[2])
          else
            temp << enq.send(i)
          end
        }
        
        temp << link_to('<span class="glyphicon glyphicon-edit"></span>'.html_safe,
                        edit_enquiry_path(enq.id)) + spc +
               link_to('<span class="glyphicon glyphicon-trash"></span>'.html_safe,
                       "/enquiries/#{enq.id}",
              {:method => "delete",data: { confirm: 'Are you sure to deactivate this enquiry?' }})
       
       final << temp
     end
     
    final

  end

  def enquiries
    @enquiries ||= fetch_enquiries
  end
  
  def fetch_enquiries
    set_cols
    sc = sort_column

    if !@sFilter.nil?
      if @sFilter.titleize == "Deactivated"
        enqs = Enquiry.inactive
      else
        fet_stat = EnquiryStatus.find_by_name(@sFilter.titleize).try(:enquiries)
        enqs = fet_stat.nil? ? Enquiry.myactive(current_user) : fet_stat.myactive(current_user)
      end
    end

    if sc.is_a?(Array)
      scs = set_asso(sc[1])
      #scs = sc[1].to_s.pluralize
      join = "LEFT OUTER JOIN #{scs} asso ON asso.id = enquiries.#{sc[0]}"
      enqs = enqs.joins(join).order("asso.#{sc[2]} #{sort_direction}")
    elsif !sc.nil?
      enqs = enqs.order("enquiries.#{sc} #{sort_direction}")
    else
      enqs = Enquiry.myactive(current_user)
    end
   
    enqs = enqs.page(page).per_page(per_page)

    if params[:sSearch].present?
      res = @def_cols[params[:sSearch_0].to_sym] 
      if res.is_a?(Array)
        ress = set_asso(res[0])
#        ress = res[0].to_s.pluralize
        enqs = enqs.includes(res[0]).where("#{ress}.#{res[1].to_s} like :search", search: "%#{params[:sSearch]}%")
      elsif params[:sSearch_0].empty?
        # not implemeted if def search is selected as asso
        enqs = enqs.where("enquiries.#{@def_srch} like :search", search: "%#{params[:sSearch]}%")
      else
        enqs = enqs.where("enquiries.#{params[:sSearch_0]} like :search", search: "%#{params[:sSearch]}%")
      end
    elsif params[:sSearch_1].present?
      enqs = enqs.send(params[:sSearch_1])
    end
    
    enqs
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page 
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = [:id] + (@cols - ["statuses"])
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
  
  def select_values
    Enquiry.all.map{|i| i.status}.uniq
  end
  
   
  def set_cols
    @def_cols = {:country_id => [:country_of_origin,:name],
     :source_id => [:student_source,:name],
     :contact_type_id => [:contact_type,:name],
     :sub_agent_id => [:sub_agent,:name],
     :assigned_to => [:_ass_to,:first_name],
     :assigned_by => [:_ass_by,:first_name],
     :created_by => [:_cre_by,:first_name],
     :updated_by => [:_upd_by,:first_name],
     :status_id => [:status,:name]}
     
    @def_srch = current_user.conf.def_enq_search_col
  end
  
  def set_asso(var)
    Enquiry.myactive(current_user).reflect_on_association(var).klass.name.underscore.pluralize
  end

end
