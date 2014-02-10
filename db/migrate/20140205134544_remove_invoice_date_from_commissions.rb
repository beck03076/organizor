class RemoveInvoiceDateFromCommissions < ActiveRecord::Migration
  def up
    remove_column :commissions, :invoice_date
  end

  def down
    add_column :commissions, :invoice_date, :date
  end
end
