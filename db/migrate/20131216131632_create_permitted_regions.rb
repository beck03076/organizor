class CreatePermittedRegions < ActiveRecord::Migration
  def change
    create_table :permitted_regions do |t|
      t.integer :region_id
      t.integer :contract_id

      t.timestamps
    end
  end
end
