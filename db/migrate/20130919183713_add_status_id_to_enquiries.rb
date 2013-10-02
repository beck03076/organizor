class AddStatusIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :status_id, :integer
  end
end
