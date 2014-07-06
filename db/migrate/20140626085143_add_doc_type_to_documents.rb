class AddDocTypeToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :doc_type, :string
  end
end
