class AddFollowedAtToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :followed_at, :timestamp
  end
end
