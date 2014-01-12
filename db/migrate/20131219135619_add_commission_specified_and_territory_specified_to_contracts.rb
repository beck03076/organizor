class AddCommissionSpecifiedAndTerritorySpecifiedToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :commission_specified, :boolean
    add_column :contracts, :territory_specified, :boolean
  end
end
