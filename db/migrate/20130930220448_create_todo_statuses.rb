class CreateTodoStatuses < ActiveRecord::Migration
  def change
    create_table :todo_statuses do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
