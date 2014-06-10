class AddImpressionsCountToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :impressions_count, :integer
  end
end
