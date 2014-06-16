class RemoveProfEngLevelIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :prof_eng_level_id
  end

  def down
    add_column :registrations, :prof_eng_level_id, :integer
  end
end
