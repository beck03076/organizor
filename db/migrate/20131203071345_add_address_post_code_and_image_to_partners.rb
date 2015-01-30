class AddAddressPostCodeAndImageToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :address_post_code, :string
    add_column :partners, :image, :string
  end
end
