class CreateSmtps < ActiveRecord::Migration
  def change
    create_table :smtps do |t|
      t.string :name
      t.string :address
      t.integer :port
      t.string :domain
      t.string :user_name
      t.string :password
      t.string :authentication
      t.integer :enable_starttls_auto
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
