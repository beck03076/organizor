class AddUserableTypeAndUserableIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userable_type, :string
    add_column :users, :userable_id, :integer
  end
end
