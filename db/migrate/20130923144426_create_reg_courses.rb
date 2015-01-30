class CreateRegCourses < ActiveRecord::Migration
  def change
    create_table :reg_courses do |t|
      t.integer :city_id
      t.integer :country_id
      t.integer :partner_id
      t.integer :course_level_id
      t.string :course_subject
      t.integer :programme_type_id
      t.integer :app_status_id
      t.date :start_date
      t.date :end_date
      t.string :ins_ref_no
      
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
