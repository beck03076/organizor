class AddClToContactTypes < ActiveRecord::Migration
  def change
    add_column :contact_types, :cl, :string
  end
end
