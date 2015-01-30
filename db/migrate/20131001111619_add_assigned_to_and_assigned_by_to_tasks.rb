class AddAssignedToAndAssignedByToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_to, :integer
    add_column :tasks, :assigned_by, :integer
  end
end
