class AddCropWAndCropHToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :crop_h, :string
    add_column :documents, :crop_w, :string
  end
end
