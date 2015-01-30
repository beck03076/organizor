class AddApiIdToTaskTopics < ActiveRecord::Migration
  def change
    add_column :task_topics, :api_id, :text
  end
end
