class AddDescToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :desc, :text
  end
end
