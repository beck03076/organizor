class AddNoteToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :note, :text
  end
end
