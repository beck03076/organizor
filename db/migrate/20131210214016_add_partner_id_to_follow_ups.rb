class AddPartnerIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :partner_id, :integer
  end
end
