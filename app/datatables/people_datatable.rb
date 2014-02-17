class PeopleDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil,asso_id = nil)
    model = "person"
    
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = "PersonType".camelize.constantize
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    set_cols(model)
    @def_cols = @def_per_cols    
    @def_srch = current_user.conf.def_per_search_col
    
    @asso_model = Person    
    @item_scope = [:ignore,nil]
    
    @compound = true
  end
   
end
