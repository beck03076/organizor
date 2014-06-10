class AddResponseTimeToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :response_time, :string
  end
end
