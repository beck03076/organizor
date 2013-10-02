class AddAssignedToAndAssignedByToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :assigned_to, :integer
    add_column :follow_ups, :assigned_by, :integer
  end
end
