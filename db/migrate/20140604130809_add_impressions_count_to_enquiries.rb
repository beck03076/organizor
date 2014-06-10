class AddImpressionsCountToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :impressions_count, :integer
  end
end
