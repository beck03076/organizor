class RemovePaidAndRemainingFromCommissions < ActiveRecord::Migration
  def up
    remove_column :commissions, :paid
    remove_column :commissions, :remaining
  end

  def down
    add_column :commissions, :remaining, :decimal
    add_column :commissions, :paid, :decimal
  end
end
