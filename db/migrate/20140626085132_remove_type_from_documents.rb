class RemoveTypeFromDocuments < ActiveRecord::Migration
  def up
    remove_column :documents, :type
  end

  def down
    add_column :documents, :type, :string
  end
end
