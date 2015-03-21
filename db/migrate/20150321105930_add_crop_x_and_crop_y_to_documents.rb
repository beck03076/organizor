class AddCropXAndCropYToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :crop_x, :string
    add_column :documents, :crop_y, :string
  end
end
