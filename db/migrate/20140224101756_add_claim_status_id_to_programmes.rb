class AddClaimStatusIdToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :claim_status_id, :integer
  end
end
