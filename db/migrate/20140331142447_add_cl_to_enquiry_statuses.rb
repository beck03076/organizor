class AddClToEnquiryStatuses < ActiveRecord::Migration
  def change
    add_column :enquiry_statuses, :cl, :string
  end
end
