class AddHeadingAndModuleToSavedReports < ActiveRecord::Migration
  def change
    add_column :saved_reports, :heading, :string
    add_column :saved_reports, :module, :string
  end
end
