class AddNoteableTypeAndNoteableIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :noteable_type, :string
    add_column :notes, :noteable_id, :integer
  end
end
