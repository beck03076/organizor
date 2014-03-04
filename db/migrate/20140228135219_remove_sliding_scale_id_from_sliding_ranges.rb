class RemoveSlidingScaleIdFromSlidingRanges < ActiveRecord::Migration
  def up
    remove_column :sliding_ranges, :sliding_scale_id
  end

  def down
    add_column :sliding_ranges, :sliding_scale_id, :integer
  end
end
