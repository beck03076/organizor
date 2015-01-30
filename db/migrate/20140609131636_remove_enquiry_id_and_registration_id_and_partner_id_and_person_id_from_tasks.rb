class RemoveEnquiryIdAndRegistrationIdAndPartnerIdAndPersonIdFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :enquiry_id
    remove_column :tasks, :registration_id
    remove_column :tasks, :partner_id
    remove_column :tasks, :person_id
  end

  def down
    add_column :tasks, :person_id, :integer
    add_column :tasks, :partner_id, :integer
    add_column :tasks, :registration_id, :integer
    add_column :tasks, :enquiry_id, :integer
  end
end
