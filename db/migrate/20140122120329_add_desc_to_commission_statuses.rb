class AddDescToCommissionStatuses < ActiveRecord::Migration
  def change
    add_column :commission_statuses, :desc, :text
  end
end
