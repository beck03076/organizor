class RemoveGraduatedOutFromQualification < ActiveRecord::Migration
  def up
    remove_column :qualifications, :graduated_out
  end

  def down
    add_column :qualifications, :graduated_out, :date
  end
end
