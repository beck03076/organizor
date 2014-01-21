class AddBranchIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :branch_id, :integer
  end
end
