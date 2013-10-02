class RemoveProficienyIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :proficieny_id
  end

  def down
    add_column :registrations, :proficieny_id, :integer
  end
end
