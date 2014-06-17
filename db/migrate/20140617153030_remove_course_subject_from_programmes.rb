class RemoveCourseSubjectFromProgrammes < ActiveRecord::Migration
  def up
    remove_column :programmes, :course_subject
  end

  def down
    add_column :programmes, :course_subject, :string
  end
end
