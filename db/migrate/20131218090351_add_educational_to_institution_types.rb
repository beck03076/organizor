class AddEducationalToInstitutionTypes < ActiveRecord::Migration
  def change
    add_column :institution_types, :educational, :boolean
  end
end
