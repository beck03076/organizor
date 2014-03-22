class EnquiriesDatatable < Datatable
  include CoreColumns

  def initialize(view,cols,sFil,asso_id = nil)
    model = "enquiry"
    
    @view = view
    @cols = cols
    @sFilter = sFil
    @tab = "EnquiryStatus".camelize.constantize
    
    @model_cl = model.camelize.constantize
    @model_pl = model.pluralize

    set_cols(model)
    @def_cols = @def_enq_cols    
    @def_srch = current_user.conf.def_enq_search_col
    
    @asso_model = Enquiry.myactive(current_user)
    @item_scope = ["myactive",current_user]
    
    @compound = true
    @goto = ["/enquiries/","id"]
  end
   
end
