class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :topic_id
      t.text :desc
      t.integer :status_id
      t.datetime :duedate
      t.string :priority
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
