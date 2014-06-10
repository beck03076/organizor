class RemoveSubClassAndSubIdFromNotes < ActiveRecord::Migration
  def up
    remove_column :notes, :sub_class
    remove_column :notes, :sub_id
  end

  def down
    add_column :notes, :sub_id, :integer
    add_column :notes, :sub_class, :string
  end
end
