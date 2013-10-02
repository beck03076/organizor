class CreateEnquiryStatuses < ActiveRecord::Migration
  def change
    create_table :enquiry_statuses do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
