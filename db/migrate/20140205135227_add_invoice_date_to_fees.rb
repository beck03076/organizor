class AddInvoiceDateToFees < ActiveRecord::Migration
  def change
    add_column :fees, :invoice_date, :date
  end
end
