class AddCreatedByAndUpdatedByToRequiredDocType < ActiveRecord::Migration
  def change
    add_column :required_doc_types, :created_by, :integer
    add_column :required_doc_types, :updated_by, :integer
  end
end
