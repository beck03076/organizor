class AddImpressionsCountToPeople < ActiveRecord::Migration
  def change
    add_column :people, :impressions_count, :integer
  end
end
