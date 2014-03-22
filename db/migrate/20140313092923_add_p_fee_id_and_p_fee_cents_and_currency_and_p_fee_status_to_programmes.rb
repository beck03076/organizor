class AddPFeeIdAndPFeeCentsAndCurrencyAndPFeeStatusToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :p_fee_id, :integer
    add_column :programmes, :p_fee_cents, :integer
    add_column :programmes, :currency, :string
    add_column :programmes, :p_fee_status, :integer
  end
end
