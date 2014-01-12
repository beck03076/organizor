class AddCreatedByAndUpdatedByToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :created_by, :integer
    add_column :contracts, :updated_by, :integer
  end
end
