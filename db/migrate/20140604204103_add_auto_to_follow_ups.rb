class AddAutoToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :auto, :boolean
  end
end
