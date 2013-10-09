class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :path
      t.integer :category_id
      t.integer :registration_id

      t.timestamps
    end
  end
end
