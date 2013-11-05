class AddCreatedByAndUpdatedByToEnquiryStatuses < ActiveRecord::Migration
  def change
    add_column :enquiry_statuses, :created_by, :integer
    add_column :enquiry_statuses, :updated_by, :integer
  end
end
