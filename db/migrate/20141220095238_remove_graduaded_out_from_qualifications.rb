class RemoveGraduadedOutFromQualifications < ActiveRecord::Migration
  def up
    remove_column :qualifications, :gratuaded_out
  end

  def down
    add_column :qualifications, :gratuaded_out, :date
  end
end
