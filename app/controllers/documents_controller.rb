class DocumentsController < ApplicationController
  def index
    redirect_to "registrations_path"
  end
  
  def create
    Document.create! params[:document]
    redirect_to "/registrations/" + params[:document][:registration_id].to_s
  end
  
  def delete
     d = Document.where(id: params[:doc_id])
     d.map &:remove_path! # deleting files
     d.delete_all # deleting records
     redirect_to "/registrations/"+params[:reg_id].to_s
  end
  

end
