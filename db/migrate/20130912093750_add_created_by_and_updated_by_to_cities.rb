class AddCreatedByAndUpdatedByToCities < ActiveRecord::Migration
  def change
    add_column :cities, :created_by, :integer
    add_column :cities, :updated_by, :integer
  end
end
