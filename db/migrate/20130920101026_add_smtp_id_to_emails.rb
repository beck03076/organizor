class AddSmtpIdToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :smtp_id, :integer
  end
end
