class CreateEmailsPeople < ActiveRecord::Migration
  def change
    create_table :emails_people do |t|
      t.integer :email_id
      t.integer :person_id

      t.timestamps
    end
  end
end
