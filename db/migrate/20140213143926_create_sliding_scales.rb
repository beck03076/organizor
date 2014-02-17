class CreateSlidingScales < ActiveRecord::Migration
  def change
    create_table :sliding_scales do |t|
      t.integer :course_level_id
      t.integer :from
      t.integer :to
      t.string :commission_percentage
      t.integer :contract_id

      t.timestamps
    end
  end
end
