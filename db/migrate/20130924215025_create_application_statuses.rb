class CreateApplicationStatuses < ActiveRecord::Migration
  def change
    create_table :application_statuses do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
