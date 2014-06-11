class AddStudentSourceIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :student_source_id, :integer
  end
end
