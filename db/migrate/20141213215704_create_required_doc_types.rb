class CreateRequiredDocTypes < ActiveRecord::Migration
  def change
    create_table :required_doc_types do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
