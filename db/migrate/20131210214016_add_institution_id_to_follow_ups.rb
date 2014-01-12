class AddInstitutionIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :institution_id, :integer
  end
end
