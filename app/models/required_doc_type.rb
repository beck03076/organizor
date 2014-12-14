class RequiredDocType < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :required_doc_id, :desc
  belongs_to :required_doc

 
end
