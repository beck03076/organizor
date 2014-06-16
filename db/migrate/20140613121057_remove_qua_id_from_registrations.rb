class RemoveQuaIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :qua_id
  end

  def down
    add_column :registrations, :qua_id, :integer
  end
end
