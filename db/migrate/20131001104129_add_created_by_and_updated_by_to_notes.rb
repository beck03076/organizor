class AddCreatedByAndUpdatedByToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :created_by, :integer
    add_column :notes, :updated_by, :integer
  end
end
