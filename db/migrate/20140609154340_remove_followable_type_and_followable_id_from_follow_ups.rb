class RemoveFollowableTypeAndFollowableIdFromFollowUps < ActiveRecord::Migration
  def up
    remove_column :follow_ups, :followable_type
    remove_column :follow_ups, :followable_id
  end

  def down
    add_column :follow_ups, :followable_id, :integer
    add_column :follow_ups, :followable_type, :string
  end
end
