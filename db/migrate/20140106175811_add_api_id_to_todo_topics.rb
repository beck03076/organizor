class AddApiIdToTodoTopics < ActiveRecord::Migration
  def change
    add_column :todo_topics, :api_id, :text
  end
end
