class DocumentsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:delete_or_download,:edit,:update]

  require 'zip/zip'
  require 'zip/zipfilesystem'

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])

    respond_to do |format|      
      if @document.update_attributes(params[:document])
        format.html {redirect_to :back}
        format.json { head :no_content }
      else
        format.html {puts @document.errors.to_s; redirect_to :back}
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    output = TestDocument.new.to_pdf
    respond_to do |format|
      format.pdf { 
        send_data output, filename: "hello.pdf", type: "application/pdf", disposition: "inline"
      }
      format.html {
        render text: "<h1>Use .pdf</h1>".html_safe
      }
    end
  end
  
  def create
    Document.create! params[:document]
    
    redirect_to "/registrations/" + params[:document][:registration_id].to_s
  end
  
  def delete_or_download
  
     if params[:doc_delete]
     
         d = Document.where(id: params[:doc_id])
         d.map &:remove_path! # deleting files
         d.delete_all # deleting records
         if current_user.is_a?(User)
         if !params[:reg_id].nil?
           redirect_to "/registrations/"+params[:reg_id].to_s
         elsif !params[:contract_id].nil?
           redirect_to "/institutions/"+params[:contract_id].to_s
         end
       else
        redirect_to :root
      end

         
     elsif params[:doc_download]
     
         d = Document.where(id: params[:doc_id])
         first_doc = d.first
         temp = first_doc.path.to_s.split("/")
         temp.pop
         reg_path = temp.join "/"
         
         if !first_doc.registration_id.nil?
           final_zip = "#{first_doc.registration.ref_no}_download_selected.zip"
         elsif !first_doc.contract_id.nil?
           final_zip = "#{first_doc.contract_id}_download_selected.zip"
         end
         
         zip_file_path = "#{Rails.root}/public#{reg_path}/#{final_zip}"
         
         # see if the file exists already, and if it does, delete it.
         if File.file?(zip_file_path)
           File.delete(zip_file_path)
         end
  
         # open or create the zip file
         Zip::ZipFile.open(zip_file_path, Zip::ZipFile::CREATE) { |zipfile|
           d.each do |attachment|
           #document_file_name shd contain filename 
           #with extension(.jpg, .csv etc) and url is the path of the document.
             zipfile.add(attachment.name, "#{Rails.root}/public" + attachment.path.to_s) 
           end
         } 
         
         #send the file as an attachment to the user.
         send_file zip_file_path, 
                   :type => 'application/zip', 
                   :disposition => 'attachment', 
                   :filename => final_zip
                   
     elsif params[:doc_consolidate]

         d = Document.where(id: params[:doc_id])
         first_doc = d.first
         temp = first_doc.path.to_s.split("/")
         temp.pop
         reg_path = temp.join "/"
         
         final_pdf = "#{first_doc.registration.ref_no}_consolidated.pdf"
         pdf_file_path = "#{Rails.root}/public#{reg_path}/#{final_pdf}"
         
         # see if the file exists already, and if it does, delete it.
         if File.file?(pdf_file_path)
           File.delete(pdf_file_path)
         end
         
         # consolidation of all the docs 
         pdf = Prawn::Document.new
         #last = d.pop
         begin
             d.each do |doc|
               full_doc = "#{Rails.root}/public/" + doc.path.to_s
               
               if doc.path.file.extension == "pdf"
                  nil#pdf.start_new_page(:template => full_doc)
               else
                  pdf.image full_doc
                  pdf.start_new_page
               end
               
             end
             #pdf.image "#{Rails.root}/public/" + last.path.to_s
             pdf.render_file pdf_file_path
             #send the file as an attachment to the user.
             send_file pdf_file_path, 
                   :type => 'application/pdf', 
                   :disposition => 'attachment', 
                   :filename => final_pdf
         rescue Prawn::Errors::UnsupportedImageType
             flash[:notice] = "Choose only images such as .png, .jpeg, .jpg to consolidate!"
             redirect_to '/handle/cancan'
         end
     end
  end
  
  def consolidate
  
         
  
  end
  
  def show
    @document = Document.find(params[:id])
    t = params[:disposition]
    disp = (t.nil? ? "attachment" : t)
    send_data @document.path, filename: @document.name, disposition: "inline"
  end


  def download_all
    attachments = Upload.find(:all, :conditions => ["source_id = ?", params[:id]]) 
  end
  
  

end
