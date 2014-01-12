class AddDescToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :desc, :text
  end
end
