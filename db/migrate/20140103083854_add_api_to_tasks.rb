class AddApiToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :api, :boolean
  end
end
