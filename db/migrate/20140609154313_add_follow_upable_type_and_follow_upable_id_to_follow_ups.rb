class AddFollowUpableTypeAndFollowUpableIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :follow_upable_type, :string
    add_column :follow_ups, :follow_upable_id, :integer
  end
end
