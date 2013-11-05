class AddCreatedByAndUpdatedByToTodoTopics < ActiveRecord::Migration
  def change
    add_column :todo_topics, :created_by, :integer
    add_column :todo_topics, :updated_by, :integer
  end
end
