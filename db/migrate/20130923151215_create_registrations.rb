class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :ref_no
      t.string :first_name
      t.string :surname
      t.string :gender
      t.date :date_of_birth
      t.integer :country_id
      t.string :email1
      t.string :email2
      t.string :mobile1
      t.string :mobile2
      t.string :home_phone
      t.string :work_phone
      t.string :address_line1
      t.string :address_line2
      t.string :address_city
      t.integer :address_country_id
      t.string :address_post_code
      t.string :address_others
      t.string :passport_number
      t.date :passport_valid_till
      t.string :visa_type
      t.date :visa_valid_till
      t.integer :qua_id
      t.string :qua_subject
      t.string :qua_institution
      t.string :qua_grade
      t.string :qua_exam
      t.string :qua_score
      t.integer :proficieny_id
      t.integer :course_id
      t.integer :reg_source_id
      t.boolean :reg_direct
      t.string :reg_came_through
      t.integer :sub_agent_id
      t.string :emer_full_name
      t.string :emer_relationship
      t.string :emer_mobile
      t.string :emer_email
      t.string :flight_no
      t.date :flight_arrival_date
      t.time :flight_arrival_time
      t.string :flight_airport
      t.integer :assigned_to
      t.integer :assigned_by
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
