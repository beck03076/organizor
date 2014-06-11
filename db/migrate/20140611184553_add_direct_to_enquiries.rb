class AddDirectToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :direct, :boolean
  end
end
