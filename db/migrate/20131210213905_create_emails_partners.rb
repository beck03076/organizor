class CreateEmailsPartners < ActiveRecord::Migration
  def change
    create_table :emails_partners do |t|
      t.integer :email_id
      t.integer :partner_id

      t.timestamps
    end
  end
end
