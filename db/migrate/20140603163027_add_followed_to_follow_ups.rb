class AddFollowedToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :followed, :boolean
  end
end
