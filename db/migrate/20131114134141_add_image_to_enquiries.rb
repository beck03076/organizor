class AddImageToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :image, :string
  end
end
