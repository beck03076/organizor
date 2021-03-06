class InstitutionsDatatable
  delegate :params, :h, :link_to, 
  :number_to_currency,:image_tag,:can?,
  :edit_institution_path,:check_box_tag,:current_user, to: :@view

  def initialize(view,cols,sFil)
    @view = view
    @cols = cols
    @sFilter = sFil
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Institution.count,
      iTotalDisplayRecords: institutions.total_entries,
      aaData: data
    }
  end

private

  def data
    spc = "&nbsp;".html_safe
    dspc = "&nbsp; &nbsp;".html_safe
    
    final = []
    
    institutions.map do |ins|
       temp = []
       
       temp << check_box_tag(:tr,ins.id,false,{data: {launch: "/institutions/#{ins.id}"}}) 
       
       temp<<  link_to(image_tag("/images/icons/edi.png"),edit_institution_path(ins.id)) + spc +
               link_to(image_tag("/images/icons/del.png"),
                       "/institutions/#{ins.id}",
                       {:method => "delete",data: { confirm: 'Are you sure this delete?' }}) 

        @cols.map{|i|
          if i.is_a?(Array)
            temp << ins.send(i[1].to_s).try(i[2].to_s)
          else
            temp << ins.send(i.to_s).to_s
          end
        }
       
       final << temp
     end
     
    final
  end

  def institutions
    @institutions ||= fetch_institutions
  end
  
  def fetch_institutions
    set_cols
    sc = sort_column

    if !@sFilter.nil?      
      fet_type = InstitutionType.find_by_name(@sFilter.titleize).try(:institutions)
      inss = fet_type.nil? ? Institution.includes(:country,:city,:type) : fet_type
    end

    if sc.is_a?(Array)
      scs = set_asso(sc[1])
      join = "LEFT OUTER JOIN #{scs} asso ON asso.id = institutions.#{sc[0]}"
      inss = inss.joins(join).order("asso.#{sc[2]} #{sort_direction}")
    elsif !sc.nil?
      inss = inss.order("institutions.#{sc} #{sort_direction}")
    else
      inss = Institution.scoped
    end
   
    inss = inss.page(page).per_page(per_page)

    if params[:sSearch].present?
      res = @def_cols[params[:sSearch_0].to_sym] 
      if res.is_a?(Array)
        ress = set_asso(res[0])
        inss = inss.includes(res[0]).where("#{ress}.#{res[1].to_s} like :search", search: "%#{params[:sSearch]}%")
      elsif params[:sSearch_0].empty?
        inss = inss.where("#{@def_srch} like :search", search: "%#{params[:sSearch]}%") 
      else
        inss = inss.where("#{params[:sSearch_0]} like :search", search: "%#{params[:sSearch]}%")
      end
    elsif params[:sSearch_1].present?
      inss = inss.send(params[:sSearch_1])
    end 

    inss
    
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = [:id,:id] + (@cols - ["statuses"])
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
  
  def set_cols
    @def_cols =  {type_id: [:type,:name],
                     group_id: [:group,:name],
                     country_id: [:country, :name],
                     city_id: [:city,:name]}
    @def_srch = current_user.conf.def_ins_search_col
  end
  
   def set_asso(var)
    Institution.reflect_on_association(var).klass.name.underscore.pluralize
  end
  
    
end
