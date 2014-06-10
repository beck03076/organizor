class AddAutoToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :auto, :boolean
  end
end
