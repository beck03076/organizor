module RegistrationsHelper

  def set_doc_type(user)
    if user.is_a?(Registration)
      ["required","my_documents","universities"]
    elsif user.is_a?(User)
      %w(all students universities reports required) 
    end
  end

  def croppable_img(doc)
    if ((can? :download, Document) && (doc.img?)) 
      (" | " + 
       link_to("Set as Profile Image","/crop/#{doc.id}",{remote: true})).html_safe
    end
  end


end
