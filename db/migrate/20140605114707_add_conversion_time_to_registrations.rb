class AddConversionTimeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :conversion_time, :string
  end
end
