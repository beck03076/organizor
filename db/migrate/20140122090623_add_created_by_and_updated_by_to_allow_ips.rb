class AddCreatedByAndUpdatedByToAllowIps < ActiveRecord::Migration
  def change
    add_column :allow_ips, :created_by, :integer
    add_column :allow_ips, :updated_by, :integer
  end
end
