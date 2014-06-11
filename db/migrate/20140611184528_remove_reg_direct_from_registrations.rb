class RemoveRegDirectFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :reg_direct
  end

  def down
    add_column :registrations, :reg_direct, :boolean
  end
end
