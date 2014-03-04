class CreateSlidingRanges < ActiveRecord::Migration
  def change
    create_table :sliding_ranges do |t|
      t.integer :from
      t.integer :to
      t.string :commission_percentage
      t.integer :sliding_scale_id

      t.timestamps
    end
  end
end
