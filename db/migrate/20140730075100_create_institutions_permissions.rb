class CreateInstitutionsPermissions < ActiveRecord::Migration
  def change
    create_table :institutions_permissions do |t|
      t.integer :institution_id
      t.integer :permission_id

      t.timestamps
    end
  end
end
