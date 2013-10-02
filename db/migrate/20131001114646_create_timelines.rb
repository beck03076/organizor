class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :name
      t.integer :id
      t.integer :user_id
      t.string :user_name
      t.datetime :created_at
      t.text :desc
      t.string :a_name
      t.integer :a_id

      t.timestamps
    end
  end
end
