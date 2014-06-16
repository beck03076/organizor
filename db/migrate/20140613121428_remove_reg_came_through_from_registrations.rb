class RemoveRegCameThroughFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :reg_came_through
  end

  def down
    add_column :registrations, :reg_came_through, :string
  end
end
