class AddEmailsCountAndNotesCountAndTodosCountAndFollowUpsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :notes_count, :integer, default: 0, null: false
    add_column :registrations, :todos_count, :integer, default: 0, null: false
    add_column :registrations, :follow_ups_count, :integer, default: 0, null: false
    add_column :registrations, :emails_count, :integer, default: 0, null: false
  end
end