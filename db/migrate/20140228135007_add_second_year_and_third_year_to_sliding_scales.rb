class AddSecondYearAndThirdYearToSlidingScales < ActiveRecord::Migration
  def change
    add_column :sliding_scales, :second_year, :string
    add_column :sliding_scales, :thrid_year, :string
  end
end
