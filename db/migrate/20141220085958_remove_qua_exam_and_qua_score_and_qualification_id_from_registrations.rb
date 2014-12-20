class RemoveQuaExamAndQuaScoreAndQualificationIdFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :qua_exam
    remove_column :registrations, :qua_score
    remove_column :registrations, :qualification_id
  end

  def down
    add_column :registrations, :qualification_id, :integer
    add_column :registrations, :qua_score, :string
    add_column :registrations, :qua_exam, :string
  end
end
