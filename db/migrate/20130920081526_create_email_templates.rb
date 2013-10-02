class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :name
      t.text :desc
      t.text :subject
      t.text :body
      t.text :signature
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
