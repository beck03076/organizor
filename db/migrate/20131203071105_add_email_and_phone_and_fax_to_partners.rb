class AddEmailAndPhoneAndFaxToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :email, :string
    add_column :partners, :phone, :string
    add_column :partners, :fax, :string
  end
end
