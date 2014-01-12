class AddContractCategoryIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :contract_category_id, :integer
  end
end
