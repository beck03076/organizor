class CreateContractStatuses < ActiveRecord::Migration
  def change
    create_table :contract_statuses do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
