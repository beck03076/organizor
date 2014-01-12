class AddInstitutionIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :institution_id, :integer
  end
end
