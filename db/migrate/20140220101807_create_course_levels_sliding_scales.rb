class CreateCourseLevelsSlidingScales < ActiveRecord::Migration
  def change
    create_table :course_levels_sliding_scales do |t|
      t.integer :course_level_id
      t.integer :sliding_scale_id

      t.timestamps
    end
  end
end
