class CreatePermissionsRegistrations < ActiveRecord::Migration
  def change
    create_table :permissions_registrations do |t|
      t.integer :permission_id
      t.integer :registration_id

      t.timestamps
    end
  end
end
