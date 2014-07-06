class AddCreatedByAndUpdatedByToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :created_by, :integer
    add_column :documents, :updated_by, :integer
  end
end
