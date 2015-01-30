class AddGroupIdToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :group_id, :integer
  end
end
