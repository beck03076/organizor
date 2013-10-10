class AddRegistrationIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :registration_id, :integer
  end
end
