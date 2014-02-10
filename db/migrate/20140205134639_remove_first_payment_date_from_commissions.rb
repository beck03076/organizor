class RemoveFirstPaymentDateFromCommissions < ActiveRecord::Migration
  def up
    remove_column :commissions, :first_payment_date
  end

  def down
    add_column :commissions, :first_payment_date, :date
  end
end
