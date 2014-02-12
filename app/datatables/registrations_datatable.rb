class RegistrationsDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil)
    model = "registration"
    
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = "ApplicationStatus".camelize.constantize
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    
    set_cols(model)
    @def_cols = @def_reg_cols    
    @def_srch = current_user.conf.def_reg_search_col
    
    @asso_model = Registration.mine(current_user)    
    @item_scope = ["mine",current_user]
    
    @compound = true
  end
   
end
