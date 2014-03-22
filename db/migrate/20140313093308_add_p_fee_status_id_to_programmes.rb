class AddPFeeStatusIdToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :p_fee_status_id, :integer
  end
end
