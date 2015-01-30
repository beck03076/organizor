class AddPersonIdToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :person_id, :integer
  end
end
