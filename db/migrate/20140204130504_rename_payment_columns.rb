class RenamePaymentColumns < ActiveRecord::Migration
  def up
    rename_column :payments,:commission, :commission_percentage 
    rename_column :payments,:amount, :commission_amount
  end

  def down
  end
end
