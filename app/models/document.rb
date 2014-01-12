class Document < ActiveRecord::Base
  attr_accessible :category_id, :name, :path, 
  :registration_id, :remove_path,:contract_id,
  :contract_category_id
  
  belongs_to :registration
  belongs_to :category,class_name: "DocCategory",foreign_key: "category_id"
  belongs_to :contract_category,class_name: "ContractDocCategory",foreign_key: "contract_category_id"
  belongs_to :contract
  
  
  mount_uploader :path, DocumentUploader
end
