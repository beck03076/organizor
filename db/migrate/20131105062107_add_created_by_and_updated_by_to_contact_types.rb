class AddCreatedByAndUpdatedByToContactTypes < ActiveRecord::Migration
  def change
    add_column :contact_types, :created_by, :integer
    add_column :contact_types, :updated_by, :integer
  end
end
