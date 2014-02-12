class ProgrammesDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil)
    model = "programme"
    
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = "CourseLevel".camelize.constantize
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    set_cols(model)
    @def_cols = @def_pro_cols    
    @def_srch = current_user.conf.def_pro_search_col
    
    @asso_model = Programme
    @item_scope = [:ignore,nil]
    
    @compound = false
  end
   
end
