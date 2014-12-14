class CreateApproveRequests < ActiveRecord::Migration
  def change
    create_table :approve_requests do |t|
      t.integer :registration_id
      t.integer :request_to
      t.text :values
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
