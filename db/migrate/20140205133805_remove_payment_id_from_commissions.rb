class RemovePaymentIdFromCommissions < ActiveRecord::Migration
  def up
    remove_column :commissions, :payment_id
  end

  def down
    add_column :commissions, :payment_id, :integer
  end
end
