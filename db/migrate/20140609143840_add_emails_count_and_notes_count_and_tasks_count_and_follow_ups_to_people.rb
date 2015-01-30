class AddEmailsCountAndNotesCountAndTasksCountAndFollowUpsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :notes_count, :integer, default: 0, null: false
    add_column :people, :tasks_count, :integer, default: 0, null: false
    add_column :people, :follow_ups_count, :integer, default: 0, null: false
    add_column :people, :emails_count, :integer, default: 0, null: false
  end
end
