class AddProfExamIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :prof_exam_id, :integer
  end
end
