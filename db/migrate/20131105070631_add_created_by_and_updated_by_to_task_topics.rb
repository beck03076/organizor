class AddCreatedByAndUpdatedByToTaskTopics < ActiveRecord::Migration
  def change
    add_column :task_topics, :created_by, :integer
    add_column :task_topics, :updated_by, :integer
  end
end
