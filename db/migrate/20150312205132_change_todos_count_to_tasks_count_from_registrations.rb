class ChangeTodosCountToTasksCountFromRegistrations < ActiveRecord::Migration
  def change
    rename_column :registrations, :todos_count, :tasks_count
  end
end
