class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.integer :poc
      t.integer :city_id
      t.integer :country_id
      t.integer :type_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
