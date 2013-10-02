class CreateProficiencies < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.integer :prof_eng_level_id
      t.integer :prof_exam_id

      t.timestamps
    end
  end
end
