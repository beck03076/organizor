class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :tuition_fee
      t.string :commission
      t.float :amount
      t.integer :programme_id

      t.timestamps
    end
  end
end
