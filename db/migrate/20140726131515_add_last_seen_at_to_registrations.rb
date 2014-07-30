class AddLastSeenAtToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :last_seen_at, :datetime
  end
end
