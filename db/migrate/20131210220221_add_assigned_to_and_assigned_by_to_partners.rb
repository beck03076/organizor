class AddAssignedToAndAssignedByToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :assigned_to, :integer
    add_column :partners, :assigned_by, :integer
  end
end
