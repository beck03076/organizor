class RegistrationsDatatable
  delegate :params, :h, :link_to, :number_to_currency,:image_tag,:can?,:edit_registration_path, to: :@view

  def initialize(view,cols,sFil)
    @view = view
    @cols = cols
    @sFilter = sFil
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Registration.count,
      iTotalDisplayRecords: registrations.total_entries,
      aaData: data
    }
  end

private

  def data
  
    final = []
    registrations.map do |reg|
       temp = []
       
       temp << link_to("edit ",edit_registration_path(reg.id)) + 
               link_to("| delete",
                       "/registrations/#{reg.id}",
                       {:method => "delete",data: { confirm: 'Are you sure this delete?' }}) +
               link_to("| launch",
                       "/registrations/#{reg.id}")

        @cols.map{|i|
          if i.is_a?(Array)
            temp << reg.send(i[1].to_s).try(i[2].to_s)
          else
            temp << reg.send(i.to_s)
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
      regs = ApplicationStatus.find_by_name(@sFilter.titleize).try(:registrations) || Registration 
    end

    if sc.is_a?(Array)
      scs = sc[1].to_s.pluralize
      join = "LEFT OUTER JOIN #{scs} ON #{scs}.id = registrations.#{sc[0]}"
      regs = regs.joins(join).order("#{sc[2]} #{sort_direction}")
    elsif !sc.nil?
      regs = regs.order("#{sc} #{sort_direction}")
    else
      regs = Registration
    end
   
    regs = regs.page(page).per_page(per_page)

    if params[:sSearch].present?
      res = @def_cols[params[:sSearch_0].to_sym] 
      if res.is_a?(Array)
        ress = res[0].to_s.pluralize
        regs = regs.includes(res[0]).where("#{ress}.#{res[1].to_s} like :search", search: "%#{params[:sSearch]}%")
      else
        regs = regs.where("#{params[:sSearch_0]} like :search", search: "%#{params[:sSearch]}%")
      end
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
    columns = [:first_name] + (@cols - ["statuses"])
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
  
  def select_values
    Registration.all.map{|i| i.status}.uniq
  end
  
   
  def set_cols
    @def_cols = {:country_id => [:country,:name],
     :qua_id => [:qualification,:name],
     :reg_source_id => [:student_source,:name],
     :sub_agent_id => [:sub_agent,:name],
     :assigned_to => :ass_to,
     :assigned_by => :ass_by,
     :created_by => :cre_by,
     :updated_by => :upd_by,
     :prof_eng_level_id => [:english_level,:name]}
  end
  
    
end
