class AddContractIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :contract_id, :integer
  end
end
