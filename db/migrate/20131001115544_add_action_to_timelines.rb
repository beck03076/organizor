class AddActionToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :action, :string
  end
end
