class AddInstitutionIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :institution_id, :integer
  end
end
