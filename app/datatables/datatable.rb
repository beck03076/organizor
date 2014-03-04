class Datatable < DeviseController
  delegate :params, :h, :link_to, 
  :number_to_currency,:image_tag,:can?,
  :check_box_tag,:current_user, to: :@view

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @asso_model.count,
      iTotalDisplayRecords: (items.total_entries rescue 0),
      aaData: data
    }
  end

protected

  def data
    spc = "&nbsp;".html_safe
    dspc = "&nbsp; &nbsp;".html_safe
    
    final = []

    items.map do |obj|
       temp = []
       
       #compound means to include follow ups in the datatable
       if @compound
           # setting the class so that the row be red for todays follow up
           fu_now_temp = obj.f_ups.map{|i|  (i.to_date == Date.today rescue nil) }.include?(true)
           # setting the class so that the row be red for this weeks follow up
           fu_week_temp = obj.f_ups.map{|i|((Date.today.at_beginning_of_week..Date.today.at_end_of_week).cover?(i.to_date) rescue nil) }.include?(true)
           
           v_fu_now = (fu_now_temp ? "fu_now" : "")
           v_fu_week = (fu_week_temp ? "fu_week" : "")
       
       else
           v_fu_now = ("")
           v_fu_week = ("")
       end
       temp << check_box_tag(:tr,obj.id,false,{data: {launch: "/#{@model_pl}/#{obj.id}",
                                                      fu_now: v_fu_now,
                                                      fu_week: v_fu_week}}) 
                                                      
       
       
       @cols.map{|i|
          if i.is_a?(Array)
            temp << obj.send(i[1].to_s).try(i[2].to_s)
          else
            temp << obj.send(i.to_s).to_s
          end
        }
        
        # display more option to click and view the extra information
        if @more
          temp << link_to('<span class="glyphicon glyphicon-th-large"></span>'.html_safe,
                          "/#{@model_pl}/#{obj.id}/more", {remote: true,
                                                           id: "more_#{obj.id}" } )
        end
        # different edit link for programmes_datatable
        if @links == "programme"
             # sometimes the programme wont have fees
             if obj.fee.nil? 
               temp << '<span title="No fees updated!" class="pointer glyphicon glyphicon-info-sign"></span>'
             else
               temp << link_to('<span class="glyphicon glyphicon-edit"></span>'.html_safe, 
                              "/fees/#{obj.fee.id}/edit",
                             {remote: true,
                              onclick: '$("div.row-top > h3").append("<img class=temp src=/images/icons/sload.gif >");'})
             end
        else
          temp << link_to('<span class="glyphicon glyphicon-edit"></span>'.html_safe,
                        "/#{@model_pl}/#{obj.id}/edit")
          temp << link_to('<span class="glyphicon glyphicon-trash"></span>'.html_safe,
                       "/#{@model_pl}/#{obj.id}",
                       {:method => "delete",data: { confirm: 'Are you sure this delete?' }}) 
        end
        
       
       final << temp
     end
    final

  end

  def items
    if (params[:sSearch_2] == "undefined" || params[:sSearch_2] == "")
      @items ||= fetch_items
    else    
      json = params[:sSearch_2]
      parsed = JSON.parse(json) if json && json.length >= 2
      
      @search = @asso_model.search(parsed)
      items = @search.result(distinct: true)
      @items = items.page(page).per_page(per_page)
    end
  end
  
  def fetch_items
    sc = sort_column

    if !@sFilter.nil?
      sFilTit = @sFilter.titleize
      if sFilTit == "Deactivated"
        items = Enquiry.inactive
      elsif sFilTit == "All" || "Finance"
        items = @asso_model        
      else
        if @tab.nil?
          fet_stat = nil
        else
          fet_stat= @tab.find_by_name(@sFilter.titleize).try(@model_pl.to_sym)
        end
        
        items = fet_stat.blank? ? [] : fet_stat.send(@item_scope[0],@item_scope[1])
      end
    end
    if !items.blank?
        if sc.is_a?(Array)
          scs = set_asso(sc[1])
          join = "LEFT OUTER JOIN #{scs} asso ON asso.id = #{@model_pl}.#{sc[0]}"
          items = items.joins(join).order("asso.#{sc[2]} #{sort_direction}")
        elsif !sc.nil?
          items = items.order("#{@model_pl}.#{sc} #{sort_direction}")
        else
          items = @asso_model
        end
        
        items = items.page(page).per_page(per_page)
    end
    
    

    if params[:sSearch].present?
      res = @def_cols[params[:sSearch_0].to_sym] 
      if res.is_a?(Array)
        ress = set_asso(res[0])
        items = items.includes(res[0]).where("#{ress}.#{res[1].to_s} like :search", search: "%#{params[:sSearch]}%")
      elsif params[:sSearch_0].empty?
        items = items.where("#{@model_pl}.#{@def_srch} like :search", search: "%#{params[:sSearch]}%") 
      else
        items = items.where("#{@model_pl}.#{params[:sSearch_0]} like :search", search: "%#{params[:sSearch]}%")
      end
    elsif params[:sSearch_1].present?
      items = items.send(params[:sSearch_1])
    end 

    items
    
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
  
  def set_asso(var)
    @asso_model.reflect_on_association(var).klass.name.underscore.pluralize
  end
    
end
