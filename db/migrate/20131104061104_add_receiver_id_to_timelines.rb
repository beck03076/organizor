class AddReceiverIdToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :receiver_id, :integer
  end
end
