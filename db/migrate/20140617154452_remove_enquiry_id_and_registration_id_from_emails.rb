class RemoveEnquiryIdAndRegistrationIdFromEmails < ActiveRecord::Migration
  def up
    remove_column :emails, :enquiry_id
    remove_column :emails, :registration_id
  end

  def down
    add_column :emails, :registration_id, :integer
    add_column :emails, :enquiry_id, :integer
  end
end
