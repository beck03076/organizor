class RemoveUserIdFromEmails < ActiveRecord::Migration
  def up
    remove_column :emails, :user_id
  end

  def down
    add_column :emails, :user_id, :integer
  end
end
