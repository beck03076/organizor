class AddQualificationIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :qualification_id, :integer
  end
end
