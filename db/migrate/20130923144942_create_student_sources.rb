class CreateStudentSources < ActiveRecord::Migration
  def change
    create_table :student_sources do |t|
      t.string :name
      t.text :desc
      t.integer :contact_id
      
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
