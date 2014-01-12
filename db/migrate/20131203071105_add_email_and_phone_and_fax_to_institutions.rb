class AddEmailAndPhoneAndFaxToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :email, :string
    add_column :institutions, :phone, :string
    add_column :institutions, :fax, :string
  end
end
