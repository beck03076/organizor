class AddFirstPaymentDateToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :first_payment_date, :date
  end
end
