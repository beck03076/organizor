class AddApiIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :api_id, :text
  end
end
