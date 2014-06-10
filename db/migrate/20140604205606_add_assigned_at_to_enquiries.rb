class AddAssignedAtToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :assigned_at, :datetime
  end
end
