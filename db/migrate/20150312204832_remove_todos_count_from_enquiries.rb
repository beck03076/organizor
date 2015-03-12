class RemoveTodosCountFromEnquiries < ActiveRecord::Migration
  def change
    remove_column :enquiries, :todos_count
  end
end
