class AddTaskableTypeAndTaskableIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :taskable_type, :string
    add_column :tasks, :taskable_id, :integer
  end
end
