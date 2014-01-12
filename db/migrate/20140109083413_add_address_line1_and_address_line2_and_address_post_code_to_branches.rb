class AddAddressLine1AndAddressLine2AndAddressPostCodeToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :address_line1, :string
    add_column :branches, :address_line2, :string
    add_column :branches, :address_post_code, :string
  end
end
