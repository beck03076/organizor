class AddThirdYearToSlidingScales < ActiveRecord::Migration
  def change
    add_column :sliding_scales, :third_year, :string
  end
end
