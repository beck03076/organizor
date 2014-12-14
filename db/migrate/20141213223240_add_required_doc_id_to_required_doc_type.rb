class AddRequiredDocIdToRequiredDocType < ActiveRecord::Migration
  def change
    add_column :required_doc_types, :required_doc_id, :integer
  end
end
