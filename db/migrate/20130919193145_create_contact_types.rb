class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|
      t.string :name
      t.string :desc
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
