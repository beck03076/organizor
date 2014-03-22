class CreateProcessingFeeTypes < ActiveRecord::Migration
  def change
    create_table :processing_fee_types do |t|
      t.string :name
      t.text :desc
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
