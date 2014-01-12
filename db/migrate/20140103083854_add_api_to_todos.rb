class AddApiToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :api, :boolean
  end
end
