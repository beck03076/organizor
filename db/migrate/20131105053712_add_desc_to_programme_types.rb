class AddDescToProgrammeTypes < ActiveRecord::Migration
  def change
    add_column :programme_types, :desc, :text
  end
end
