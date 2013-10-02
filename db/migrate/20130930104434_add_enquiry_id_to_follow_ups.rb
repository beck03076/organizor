class AddEnquiryIdToFollowUps < ActiveRecord::Migration
  def change
    add_column :follow_ups, :enquiry_id, :integer
  end
end
