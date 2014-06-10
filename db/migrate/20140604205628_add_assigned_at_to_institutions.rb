class AddAssignedAtToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :assigned_at, :datetime
  end
end
