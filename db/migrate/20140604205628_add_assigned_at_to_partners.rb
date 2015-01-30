class AddAssignedAtToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :assigned_at, :datetime
  end
end
