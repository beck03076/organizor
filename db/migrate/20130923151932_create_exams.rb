class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.date :exam_date
      t.integer :exam_type_id
      t.string :exam_score

      t.timestamps
    end
  end
end
