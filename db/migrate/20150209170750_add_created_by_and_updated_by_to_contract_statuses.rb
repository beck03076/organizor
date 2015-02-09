class AddCreatedByAndUpdatedByToContractStatuses < ActiveRecord::Migration
  def change
    add_column :contract_statuses, :created_by, :integer
    add_column :contract_statuses, :updated_by, :integer
  end
end
