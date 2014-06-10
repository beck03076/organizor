class AddImpressionsCountToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :impressions_count, :integer
  end
end
