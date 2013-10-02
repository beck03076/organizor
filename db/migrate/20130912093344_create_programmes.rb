class CreateProgrammes < ActiveRecord::Migration
  def change
    create_table :programmes do |t|
      t.integer :type_id
      t.integer :country_id
      t.integer :city_id
      t.integer :institution_id
      t.integer :level_id
      t.integer :subject_id
      t.date :start_date
      t.date :end_date
      t.integer :enquiry_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
