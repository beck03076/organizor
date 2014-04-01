class AddClToStudentSources < ActiveRecord::Migration
  def change
    add_column :student_sources, :cl, :string
  end
end
