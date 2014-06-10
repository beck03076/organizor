class AddConversionTimeToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :conversion_time, :string
  end
end
