class AddApiIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :api_id, :text
  end
end
