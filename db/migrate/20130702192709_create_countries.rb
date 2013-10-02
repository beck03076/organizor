class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.text :desc
      t.string :code
      t.column :continent, "enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')", :default => "Asia"
      t.string :region
      t.string :government_form
      t.string :local_name
      t.integer :capital_city_id

      t.timestamps
    end
  end
end
