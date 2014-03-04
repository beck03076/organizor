module ActionsMethods
  # ===========
  # = Methods =
  # ===========

       def meta(user_id,core,act,core_id,what)
         if what == "by"
          whr = "created_by"
         elsif what == "to"
          whr = "assigned_to"
         end
         total = core.camelize.constantize.find(core_id).send(act).size
         out = core.camelize.constantize.find(core_id).send(act).where(whr.to_sym => user_id).size
         [total,out,what +' me']
       end
      

end
