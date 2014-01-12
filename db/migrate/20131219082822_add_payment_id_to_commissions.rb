class AddPaymentIdToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :payment_id, :integer
  end
end
