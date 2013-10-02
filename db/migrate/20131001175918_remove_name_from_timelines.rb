class RemoveNameFromTimelines < ActiveRecord::Migration
  def up
    remove_column :timelines, :name
  end

  def down
    add_column :timelines, :name, :string
  end
end
