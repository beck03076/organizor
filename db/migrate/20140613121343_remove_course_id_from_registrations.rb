class RemoveCourseIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :course_id
  end

  def down
    add_column :registrations, :course_id, :integer
  end
end
