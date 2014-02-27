class AddProgressionStatusIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :progression_status_id, :integer
  end
end
