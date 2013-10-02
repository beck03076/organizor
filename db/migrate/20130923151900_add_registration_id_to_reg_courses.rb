class AddRegistrationIdToRegCourses < ActiveRecord::Migration
  def change
    add_column :reg_courses, :registration_id, :integer
  end
end
