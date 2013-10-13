class AddContactTypeIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :contact_type_id, :integer
  end
end
