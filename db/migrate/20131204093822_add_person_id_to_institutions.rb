class AddPersonIdToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :person_id, :integer
  end
end
