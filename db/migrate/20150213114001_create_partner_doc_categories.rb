class CreatePartnerDocCategories < ActiveRecord::Migration
  def change
    create_table :partner_doc_categories do |t|
      t.string :name
      t.text :desc
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
