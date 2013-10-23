class AddSubjectVarToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :subject_var, :string
  end
end
