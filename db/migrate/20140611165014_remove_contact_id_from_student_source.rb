class RemoveContactIdFromStudentSource < ActiveRecord::Migration
  def up
    remove_column :student_sources, :contact_id
  end

  def down
    add_column :student_sources, :contact_id, :integer
  end
end
