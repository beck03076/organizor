class AddCheckedToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :checked, :boolean, :default => false 
  end
end
