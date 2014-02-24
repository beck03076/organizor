class ProgrammesDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil,asso_id = nil)
    model = "programme"
    
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = nil
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    set_cols(model)
    @def_cols = @def_pro_cols    
    @def_srch = current_user.conf.def_pro_search_col
    
    @asso_model = Programme.joined_ins(asso_id)
    @item_scope = ["joined_ins",asso_id]
    
    @compound = false
    @more = true
  end
   
end
