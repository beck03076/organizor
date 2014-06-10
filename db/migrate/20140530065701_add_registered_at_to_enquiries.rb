class AddRegisteredAtToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :registered_at, :date
  end
end
