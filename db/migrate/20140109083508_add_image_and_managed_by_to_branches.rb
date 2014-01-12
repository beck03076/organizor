class AddImageAndManagedByToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :image, :string
    add_column :branches, :managed_by, :integer
  end
end
