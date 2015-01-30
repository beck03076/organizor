class CreateTaskTopics < ActiveRecord::Migration
  def change
    create_table :task_topics do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
