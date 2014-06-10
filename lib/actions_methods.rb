module ActionsMethods
  # ===========
  # = Methods =
  # ===========

       def meta(user_id,core,act,core_obj,what)
         if what == "by"
          whr = "created_by"
         elsif what == "to"
          whr = "assigned_to"
         end
         total = core_obj.send(act).size
         out = core_obj.send(act).where(whr.to_sym => user_id).size
         [total,out,what +' me']
       end
      

end
