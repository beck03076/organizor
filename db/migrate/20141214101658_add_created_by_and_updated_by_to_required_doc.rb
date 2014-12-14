class AddCreatedByAndUpdatedByToRequiredDoc < ActiveRecord::Migration
  def change
    add_column :required_docs, :created_by, :integer
    add_column :required_docs, :updated_by, :integer
  end
end
