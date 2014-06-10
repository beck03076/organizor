class AddAssignedAtToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :assigned_at, :datetime
  end
end
