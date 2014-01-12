class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.decimal :paid, :precision => 8, :scale => 2
      t.date :date_received
      t.decimal :remaining, :precision => 8, :scale => 2
      t.integer :status_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
