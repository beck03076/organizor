class CreateStatusDiagrams < ActiveRecord::Migration
  def change
    create_table :status_diagrams do |t|
      t.integer :status_id
      t.integer :user_id
      t.integer :programme_id

      t.timestamps
    end
  end
end
