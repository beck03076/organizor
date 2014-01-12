class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :surname
      t.string :mobile
      t.string :email
      t.string :work_phone
      t.string :home_phone
      t.date :date_of_birth
      t.string :gender
      t.string :address_line1
      t.string :address_line2
      t.integer :city_id
      t.integer :country_id
      t.string :address_post_code
      t.string :image
      t.string :skype
      t.string :facebook
      t.string :linkedin
      t.string :twitter
      t.string :gplus
      t.string :blogger
      t.string :website
      t.text :desc
      t.string :subject_class
      t.integer :subject_id

      t.timestamps
    end
  end
end
