class AddContactTypeIdToStudentSource < ActiveRecord::Migration
  def change
    add_column :student_sources, :contact_type_id, :integer
  end
end
