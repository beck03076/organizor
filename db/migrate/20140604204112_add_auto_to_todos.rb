class AddAutoToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :auto, :boolean
  end
end
