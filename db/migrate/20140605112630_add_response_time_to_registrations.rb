class AddResponseTimeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :response_time, :string
  end
end
