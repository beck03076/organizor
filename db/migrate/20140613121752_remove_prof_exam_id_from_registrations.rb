class RemoveProfExamIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :prof_exam_id
  end

  def down
    add_column :registrations, :prof_exam_id, :integer
  end
end
