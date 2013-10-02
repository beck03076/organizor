class CreatePreferredCountries < ActiveRecord::Migration
  def change
    create_table :preferred_countries do |t|
      t.integer :country_id
      t.integer :enquiry_id
      t.integer :priority

      t.timestamps
    end
  end
end
