class AddProfEngLevelIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :prof_eng_level_id, :integer
  end
end
