class AddCourseSubjectTextToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :course_subject_text, :string
  end
end
