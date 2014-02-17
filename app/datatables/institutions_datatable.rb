class InstitutionsDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil,asso_id = nil)
    model = "institution"
    
    
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = "InstitutionType".camelize.constantize
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    set_cols(model)
    @def_cols = @def_ins_cols    
    @def_srch = current_user.conf.def_ins_search_col
    
    @asso_model = Institution
    @item_scope = [:ignore,nil]
    
    @compound = true
  end
    
end
