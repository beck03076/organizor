class AddRegistrationIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :registration_id, :integer
  end
end
