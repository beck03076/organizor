class RemoveSourceIdFromEnquiries < ActiveRecord::Migration
  def up
    remove_column :enquiries, :source_id
  end

  def down
    add_column :enquiries, :source_id, :integer
  end
end
