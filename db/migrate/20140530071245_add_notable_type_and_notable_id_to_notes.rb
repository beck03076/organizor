class AddNotableTypeAndNotableIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :notable_type, :string
    add_column :notes, :notable_id, :integer
  end
end
