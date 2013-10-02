class AddActiveToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :active, :boolean, :default => true
  end
end
