class AddPFeeBankDetailsToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :p_fee_bank_details, :text
  end
end
