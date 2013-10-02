class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :to
      t.text :from
      t.text :cc
      t.text :bcc
      t.text :subject
      t.text :body
      t.string :attachment
      t.integer :user_id
      t.integer :enquiry_id
      t.integer :registration_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
