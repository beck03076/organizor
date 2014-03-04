class AddPaidCentsAndRemainingCentsFromCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :paid_cents, :integer
    add_column :commissions, :remaining_cents, :integer
  end
end
