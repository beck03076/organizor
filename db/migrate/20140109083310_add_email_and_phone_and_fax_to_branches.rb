class AddEmailAndPhoneAndFaxToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :email, :string
    add_column :branches, :phone, :string
    add_column :branches, :fax, :string
  end
end
