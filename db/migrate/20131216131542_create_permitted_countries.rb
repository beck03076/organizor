class CreatePermittedCountries < ActiveRecord::Migration
  def change
    create_table :permitted_countries do |t|
      t.integer :country_id
      t.integer :contract_id

      t.timestamps
    end
  end
end
