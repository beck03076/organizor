class RemovePFeeStatusFromProgrammes < ActiveRecord::Migration
  def up
    remove_column :programmes, :p_fee_status
  end

  def down
    add_column :programmes, :p_fee_status, :integer
  end
end
