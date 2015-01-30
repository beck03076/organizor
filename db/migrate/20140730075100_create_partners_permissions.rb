class CreatePartnersPermissions < ActiveRecord::Migration
  def change
    create_table :partners_permissions do |t|
      t.integer :partner_id
      t.integer :permission_id

      t.timestamps
    end
  end
end
