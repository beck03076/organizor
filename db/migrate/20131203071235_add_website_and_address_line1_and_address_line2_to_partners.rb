class AddWebsiteAndAddressLine1AndAddressLine2ToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :website, :string
    add_column :partners, :address_line1, :string
    add_column :partners, :address_line2, :string
  end
end
