class AddRegistrationIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :registration_id, :integer
  end
end
