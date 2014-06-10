class AddTodoableTypeAndTodoableIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :todoable_type, :string
    add_column :todos, :todoable_id, :integer
  end
end
