class AddEnquiryIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :enquiry_id, :integer
  end
end
