class AddWebsiteAndAddressLine1AndAddressLine2ToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :website, :string
    add_column :institutions, :address_line1, :string
    add_column :institutions, :address_line2, :string
  end
end
