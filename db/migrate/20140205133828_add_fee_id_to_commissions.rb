class AddFeeIdToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :fee_id, :integer
  end
end
