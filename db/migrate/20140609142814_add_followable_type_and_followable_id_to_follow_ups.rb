class AddFollowableTypeAndFollowableIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :followable_type, :string
    add_column :follow_ups, :followable_id, :integer
  end
end
