class CreateProcessingFeeStatuses < ActiveRecord::Migration
  def change
    create_table :processing_fee_statuses do |t|
      t.string :name
      t.text :desc
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
