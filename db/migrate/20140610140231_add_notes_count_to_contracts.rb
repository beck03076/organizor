class AddNotesCountToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :notes_count, :integer,default: 0,null: false
  end
end
