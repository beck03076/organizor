class AddCreatedByAndUpdatedByToTodoStatuses < ActiveRecord::Migration
  def change
    add_column :todo_statuses, :created_by, :integer
    add_column :todo_statuses, :updated_by, :integer
  end
end
