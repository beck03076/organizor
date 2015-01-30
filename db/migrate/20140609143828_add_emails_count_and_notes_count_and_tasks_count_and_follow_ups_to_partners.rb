class AddEmailsCountAndNotesCountAndTasksCountAndFollowUpsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :notes_count, :integer, default: 0, null: false
    add_column :partners, :tasks_count, :integer, default: 0, null: false
    add_column :partners, :follow_ups_count, :integer, default: 0, null: false
    add_column :partners, :emails_count, :integer, default: 0, null: false
  end
end
