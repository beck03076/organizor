class AddRegisteredByToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :registered_by, :integer
  end
end
