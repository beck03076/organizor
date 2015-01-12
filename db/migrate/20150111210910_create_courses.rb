class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :university
      t.string :department
      t.string :qdmode
      t.string :intake
      t.text :requirements
      t.text :intl
      t.text :desc
      t.text :ukfee
      t.text :internfee
      t.text :fund
      t.text :named_pathway
      t.text :new_enrollment
      t.text :total_enrollment
      t.text :scholarships
      t.text :gscholarships
      t.text :bursaries
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.text :contact_web
      t.string :apply_link

      t.timestamps
    end
  end
end
