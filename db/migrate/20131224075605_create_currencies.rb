class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :iso_alpha2
      t.string :iso_alpha3
      t.integer :iso_numeric
      t.string :code
      t.string :name
      t.string :symbol
      t.string :country_name
      t.integer :country_id

      t.timestamps
    end
  end
end
