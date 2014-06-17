class RemoveStatusIdFromTodos < ActiveRecord::Migration
  def up
    remove_column :todos, :status_id
  end

  def down
    add_column :todos, :status_id, :integer
  end
end
