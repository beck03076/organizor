class AddTasksCountToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :tasks_count, :integer, default: 0, null: false
  end
end
