class AddFirstPaymentDateToFees < ActiveRecord::Migration
  def change
    add_column :fees, :first_payment_date, :date
  end
end
