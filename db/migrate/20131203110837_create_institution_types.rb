class CreateInstitutionTypes < ActiveRecord::Migration
  def change
    create_table :institution_types do |t|
      t.string :name
      t.text :desc
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
