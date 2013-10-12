class EnquiriesDatatable
  delegate :params, :h, :link_to, :number_to_currency,:image_tag,:can?,:edit_enquiry_path,:check_box_tag, to: :@view

  def initialize(view,cols,sFil)
    @view = view
    @cols = cols
    @sFilter = sFil
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Enquiry.count,
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
       
       temp << check_box_tag(:tr,enq.id) + spc +
               link_to(image_tag("/images/icons/vie.png"),
                       "/enquiries/#{enq.id}") + spc +
               link_to(image_tag("/images/icons/edi.png"),edit_enquiry_path(enq.id)) + spc +
               link_to(image_tag("/images/icons/del.png"),
                       "/enquiries/#{enq.id}",
                       {:method => "delete",data: { confirm: 'Are you sure this delete?' }}) 
               

        @cols.map{|i|
          if i.is_a?(Array)
            temp << enq.send(i[1].to_s).try(i[2].to_s)
          else
            temp << enq.send(i.to_s)
          end
        }
       
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
      enqs = EnquiryStatus.find_by_name(@sFilter.titleize).try(:enquiries) || Enquiry 
    end

    if sc.is_a?(Array)
      scs = set_asso(sc[1])
      #scs = sc[1].to_s.pluralize
      join = "LEFT OUTER JOIN #{scs} ON #{scs}.id = enquiries.#{sc[0]}"
      enqs = enqs.joins(join).order("#{sc[2]} #{sort_direction}")
    elsif !sc.nil?
      enqs = enqs.order("enquiries.#{sc} #{sort_direction}")
    else
      enqs = Enquiry
    end
   
    enqs = enqs.page(page).per_page(per_page)

    if params[:sSearch].present?
      res = @def_cols[params[:sSearch_0].to_sym] 
      if res.is_a?(Array)
        ress = set_asso(res[0])
#        ress = res[0].to_s.pluralize
        enqs = enqs.includes(res[0]).where("#{ress}.#{res[1].to_s} like :search", search: "%#{params[:sSearch]}%")
      else
        enqs = enqs.where("#{params[:sSearch_0]} like :search", search: "%#{params[:sSearch]}%")
      end
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
     :sub_agent_id => [:sub_agent,:name],
     :assigned_to => [:_assigned_to,:first_name],
     :assigned_by => [:_assigned_by,:first_name],
     :created_by => [:_created_by,:first_name],
     :updated_by => [:_updated_by,:first_name],
     :status_id => [:status,:name]}
  end
  
  def set_asso(var)
    Enquiry.reflect_on_association(var).klass.name.underscore.pluralize
  end
  
    
end
