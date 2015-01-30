class PartnersDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil,asso_id = nil)
    model = "partner"
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = "PartnerType".camelize.constantize
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    set_cols(model)
    @def_cols = @def_ins_cols    
    @def_srch = current_user.conf.def_ins_search_col
    
    @asso_model = Partner
    @item_scope = [:ignore,nil]
    
    @compound = true
    @goto = ["/partners/","id"]
  end
    
end
