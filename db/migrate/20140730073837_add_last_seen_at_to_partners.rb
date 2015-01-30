class AddLastSeenAtToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :last_seen_at, :datetime
  end
end
