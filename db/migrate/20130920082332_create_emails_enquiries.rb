class CreateEmailsEnquiries < ActiveRecord::Migration
  def change
    create_table :emails_enquiries do |t|
      t.integer :email_id
      t.integer :enquiry_id

      t.timestamps
    end
  end
end
