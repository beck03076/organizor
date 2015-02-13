class AddContactStatusIdToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :contract_status_id, :integer
  end
end
