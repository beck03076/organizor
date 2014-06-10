class RemoveNotableTypeAndNotableIdFromNotes < ActiveRecord::Migration
  def up
    remove_column :notes, :notable_type
    remove_column :notes, :notable_id
  end

  def down
    add_column :notes, :notable_id, :integer
    add_column :notes, :notable_type, :string
  end
end
