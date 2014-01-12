class CreateEmailsInstitutions < ActiveRecord::Migration
  def change
    create_table :emails_institutions do |t|
      t.integer :email_id
      t.integer :institution_id

      t.timestamps
    end
  end
end
