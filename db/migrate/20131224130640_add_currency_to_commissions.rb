class AddCurrencyToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :currency, :string
  end
end
