class AddTodosCountToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :todos_count, :integer, default: 0, null: false
  end
end
