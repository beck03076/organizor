class AddCommissionPaidCentsToFees < ActiveRecord::Migration
  def change
    add_column :fees, :commission_paid_cents, :integer
  end
end
