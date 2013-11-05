class AddCreatedByAndUpdatedByToDocCategories < ActiveRecord::Migration
  def change
    add_column :doc_categories, :created_by, :integer
    add_column :doc_categories, :updated_by, :integer
  end
end
