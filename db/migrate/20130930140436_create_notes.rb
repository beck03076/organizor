class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.string :sub_class
      t.integer :sub_id

      t.timestamps
    end
  end
end
