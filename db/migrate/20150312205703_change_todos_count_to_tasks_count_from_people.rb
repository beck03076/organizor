class ChangeTodosCountToTasksCountFromPeople < ActiveRecord::Migration
  def change
    rename_column :people, :todos_count, :tasks_count
  end
end
