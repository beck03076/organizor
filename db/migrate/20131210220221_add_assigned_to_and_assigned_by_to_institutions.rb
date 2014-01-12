class AddAssignedToAndAssignedByToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :assigned_to, :integer
    add_column :institutions, :assigned_by, :integer
  end
end
