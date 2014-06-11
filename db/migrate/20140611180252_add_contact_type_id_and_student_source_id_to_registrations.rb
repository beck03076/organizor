class AddContactTypeIdAndStudentSourceIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :contact_type_id, :integer
    add_column :registrations, :student_source_id, :integer
  end
end
