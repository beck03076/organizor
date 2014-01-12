class RemovePocFromInstitutions < ActiveRecord::Migration
  def up
    remove_column :institutions, :poc
  end

  def down
    add_column :institutions, :poc, :integer
  end
end
