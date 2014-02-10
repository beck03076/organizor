class RenameDateReceivedToInvoiceDateCommissions < ActiveRecord::Migration
  def up
    rename_column :commissions, :date_received, :invoice_date
  end

  def down
  end
end
