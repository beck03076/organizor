class CreateCommissionStatuses < ActiveRecord::Migration
  def change
    create_table :commission_statuses do |t|
      t.string :name
      t.integer :desc
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
