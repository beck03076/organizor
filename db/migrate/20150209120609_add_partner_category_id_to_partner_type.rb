class AddPartnerCategoryIdToPartnerType < ActiveRecord::Migration
  def change
    add_column :partner_types, :partner_category_id, :integer
  end
end
