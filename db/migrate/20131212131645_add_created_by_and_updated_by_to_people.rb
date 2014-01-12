class AddCreatedByAndUpdatedByToPeople < ActiveRecord::Migration
  def change
    add_column :people, :created_by, :integer
    add_column :people, :updated_by, :integer
  end
end
