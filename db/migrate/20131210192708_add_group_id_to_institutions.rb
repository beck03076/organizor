class AddGroupIdToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :group_id, :integer
  end
end
