class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :first_name
      t.string :surname
      t.string :mobile1
      t.string :mobile2
      t.string :email1
      t.string :email2
      t.string :gender
      t.date :date_of_birth
      t.integer :score
      t.integer :source_id
      t.integer :assigned_to
      t.integer :assigned_by
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
