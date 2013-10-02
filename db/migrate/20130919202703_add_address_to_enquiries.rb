class AddAddressToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :address, :text
  end
end
