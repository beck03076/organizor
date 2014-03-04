class CreateSlidingRangesSlidingScales < ActiveRecord::Migration
  def change
    create_table :sliding_ranges_sliding_scales do |t|
      t.integer :sliding_scale_id
      t.integer :sliding_range_id

      t.timestamps
    end
  end
end
