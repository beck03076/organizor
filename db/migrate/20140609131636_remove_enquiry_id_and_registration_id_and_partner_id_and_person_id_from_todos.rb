class RemoveEnquiryIdAndRegistrationIdAndPartnerIdAndPersonIdFromTodos < ActiveRecord::Migration
  def up
    remove_column :todos, :enquiry_id
    remove_column :todos, :registration_id
    remove_column :todos, :partner_id
    remove_column :todos, :person_id
  end

  def down
    add_column :todos, :person_id, :integer
    add_column :todos, :partner_id, :integer
    add_column :todos, :registration_id, :integer
    add_column :todos, :enquiry_id, :integer
  end
end
