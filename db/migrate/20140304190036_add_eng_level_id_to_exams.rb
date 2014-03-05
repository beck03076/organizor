class AddEngLevelIdToExams < ActiveRecord::Migration
  def change
    add_column :exams, :eng_level_id, :integer
  end
end
