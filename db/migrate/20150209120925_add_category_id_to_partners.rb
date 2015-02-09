class AddCategoryIdToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :category_id, :integer
  end
end
