class AddCreatedByAndUpdatedByToApplicationStatuses < ActiveRecord::Migration
  def change
    add_column :application_statuses, :created_by, :integer
    add_column :application_statuses, :updated_by, :integer
  end
end
