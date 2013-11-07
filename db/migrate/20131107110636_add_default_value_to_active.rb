class AddDefaultValueToActive < ActiveRecord::Migration
  def up
    change_column :enquiries, :active ,:boolean, :default => true
  end
  def down
  end
end
