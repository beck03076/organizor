class AddDirectToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :direct, :boolean
  end
end
