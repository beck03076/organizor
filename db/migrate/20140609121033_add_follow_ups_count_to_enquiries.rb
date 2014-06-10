class AddFollowUpsCountToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :follow_ups_count, :integer, default: 0, null: false
  end
end
