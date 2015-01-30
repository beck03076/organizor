class RemoveStatusIdFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :status_id
  end

  def down
    add_column :tasks, :status_id, :integer
  end
end
