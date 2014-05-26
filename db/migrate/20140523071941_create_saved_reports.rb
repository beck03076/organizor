class CreateSavedReports < ActiveRecord::Migration
  def change
    create_table :saved_reports do |t|
      t.string :name
      t.text :q
      t.integer :created_by
      t.text :desc

      t.timestamps
    end
  end
end
