class AddRegisteredToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :registered, :boolean, default: false
  end
end
