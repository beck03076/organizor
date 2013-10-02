class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :branch_id
      t.integer :role_id
      t.integer :image
      t.text :email_signature
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
