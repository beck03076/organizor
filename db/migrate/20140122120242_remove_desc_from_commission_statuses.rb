class RemoveDescFromCommissionStatuses < ActiveRecord::Migration
  def up
    remove_column :commission_statuses, :desc
  end

  def down
    add_column :commission_statuses, :desc, :integer
  end
end
