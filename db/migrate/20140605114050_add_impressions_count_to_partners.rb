class AddImpressionsCountToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :impressions_count, :integer
  end
end
