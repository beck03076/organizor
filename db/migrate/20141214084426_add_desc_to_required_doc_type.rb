class AddDescToRequiredDocType < ActiveRecord::Migration
  def change
    add_column :required_doc_types, :desc, :text
  end
end
