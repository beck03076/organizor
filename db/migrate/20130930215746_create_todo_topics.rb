class CreateTodoTopics < ActiveRecord::Migration
  def change
    create_table :todo_topics do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
