class AddNotesCountToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :notes_count, :integer, default: 0, null: false
  end
end
