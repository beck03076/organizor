class AddAssignedToAndAssignedByToPeople < ActiveRecord::Migration
  def change
    add_column :people, :assigned_to, :integer
    add_column :people, :assigned_by, :integer
  end
end
