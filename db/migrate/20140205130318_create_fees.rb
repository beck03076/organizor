class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :tuition_fee_cents
      t.string :commission_percentage
      t.integer :commission_amount_cents
      t.integer :programme_id
      t.string :currency
      t.integer :scholarship_cents
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
