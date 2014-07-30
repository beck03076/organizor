class AddLastSeenAtToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :last_seen_at, :datetime
  end
end
