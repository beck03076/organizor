class AddPersonIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :person_id, :integer
  end
end
