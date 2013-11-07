class AddEnquiryIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :enquiry_id, :integer
  end
end
