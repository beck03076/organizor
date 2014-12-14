module RegistrationsHelper

  def set_doc_type(user)
    if user.is_a?(Registration)
      ["required","my_documents","universities"]
    elsif user.is_a?(User)
      %w(all students universities reports required) 
    end
  end

end
