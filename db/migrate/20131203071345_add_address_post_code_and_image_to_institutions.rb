class AddAddressPostCodeAndImageToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :address_post_code, :string
    add_column :institutions, :image, :string
  end
end
