class AddEnquiryIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :enquiry_id, :integer
  end
end
