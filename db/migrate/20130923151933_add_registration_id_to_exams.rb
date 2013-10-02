class AddRegistrationIdToExams < ActiveRecord::Migration
  def change
    add_column :exams, :registration_id, :integer
  end
end
