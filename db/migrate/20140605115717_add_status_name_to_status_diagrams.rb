class AddStatusNameToStatusDiagrams < ActiveRecord::Migration
  def change
    add_column :status_diagrams, :status_name, :string
  end
end
