class RemovePocFromPartners < ActiveRecord::Migration
  def up
    remove_column :partners, :poc
  end

  def down
    add_column :partners, :poc, :integer
  end
end
