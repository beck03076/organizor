class RemoveFromAndToFromSlidingScales < ActiveRecord::Migration
  def up
    remove_column :sliding_scales, :from
    remove_column :sliding_scales, :to
  end

  def down
    add_column :sliding_scales, :to, :integer
    add_column :sliding_scales, :from, :integer
  end
end
