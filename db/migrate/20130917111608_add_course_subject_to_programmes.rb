class AddCourseSubjectToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :course_subject, :string
  end
end
