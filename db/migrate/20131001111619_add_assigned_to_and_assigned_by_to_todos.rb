class AddAssignedToAndAssignedByToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :assigned_to, :integer
    add_column :todos, :assigned_by, :integer
  end
end
