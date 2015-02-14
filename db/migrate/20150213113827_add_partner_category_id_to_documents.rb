class AddPartnerCategoryIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :partner_category_id, :integer
  end
end
