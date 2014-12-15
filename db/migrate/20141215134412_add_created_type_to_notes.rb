class AddCreatedTypeToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :created_type, :string
  end
end
