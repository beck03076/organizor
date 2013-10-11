class CreateEmailsRegistrations < ActiveRecord::Migration
  def change
    create_table :emails_registrations do |t|
      t.integer :registration_id
      t.integer :email_id

      t.timestamps
    end
  end
end
