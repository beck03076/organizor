class CreateProhibitedRegions < ActiveRecord::Migration
  def change
    create_table :prohibited_regions do |t|
      t.integer :region_id
      t.integer :contract_id

      t.timestamps
    end
  end
end
