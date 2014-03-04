class RemoveThridYearFromSlidingScales < ActiveRecord::Migration
  def up
    remove_column :sliding_scales, :thrid_year
  end

  def down
    add_column :sliding_scales, :thrid_year, :string
  end
end
