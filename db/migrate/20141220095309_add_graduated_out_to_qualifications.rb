class AddGraduatedOutToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :graduated_out, :date
  end
end
