class AddPersonIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :person_id, :integer
  end
end
