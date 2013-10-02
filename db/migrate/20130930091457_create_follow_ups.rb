class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.string :title
      t.text :desc
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :api
      t.integer :event_type_id
      t.string :venue
      t.integer :remind_before
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
