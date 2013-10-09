class Document < ActiveRecord::Base
  attr_accessible :category_id, :name, :path, :registration_id, :remove_path
  belongs_to :registration
  belongs_to :category,class_name: "DocCategory",foreign_key: "category_id"
  
  
  mount_uploader :path, DocumentUploader
end
