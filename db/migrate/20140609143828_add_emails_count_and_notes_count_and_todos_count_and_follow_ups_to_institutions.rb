class AddEmailsCountAndNotesCountAndTodosCountAndFollowUpsToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :notes_count, :integer, default: 0, null: false
    add_column :institutions, :todos_count, :integer, default: 0, null: false
    add_column :institutions, :follow_ups_count, :integer, default: 0, null: false
    add_column :institutions, :emails_count, :integer, default: 0, null: false
  end
end
