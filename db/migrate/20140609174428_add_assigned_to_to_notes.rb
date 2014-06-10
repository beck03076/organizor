class AddAssignedToToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :assigned_to, :integer
  end
end
