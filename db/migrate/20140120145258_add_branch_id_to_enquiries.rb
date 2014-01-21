class AddBranchIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :branch_id, :integer
  end
end
