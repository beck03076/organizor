class AddAppStatusIdAndInsRefNoAndRegistrationIdToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :app_status_id, :integer
    add_column :programmes, :ins_ref_no, :integer
    add_column :programmes, :registration_id, :integer
  end
end
