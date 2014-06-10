class AddEmailsCountToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :emails_count, :integer, default: 0, null: false
  end
end
