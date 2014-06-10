class AddAssignedAtToPeople < ActiveRecord::Migration
  def change
    add_column :people, :assigned_at, :datetime
  end
end
