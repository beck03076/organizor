class AddCreatedByAndUpdatedByToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :created_by, :integer
    add_column :event_types, :updated_by, :integer
  end
end
