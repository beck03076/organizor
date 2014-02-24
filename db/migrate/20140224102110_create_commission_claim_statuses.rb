class CreateCommissionClaimStatuses < ActiveRecord::Migration
  def change
    create_table :commission_claim_statuses do |t|
      t.string :name
      t.text :desc
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
