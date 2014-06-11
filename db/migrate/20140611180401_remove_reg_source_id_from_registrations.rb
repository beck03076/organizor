class RemoveRegSourceIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :reg_source_id
  end

  def down
    add_column :registrations, :reg_source_id, :integer
  end
end
