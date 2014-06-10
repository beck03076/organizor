class AddNotesCountToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :notes_count, :integer, default: 0, null: false
  end
end
