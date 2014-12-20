class AddGraduatedOutToQualification < ActiveRecord::Migration
  def change
    add_column :qualifications, :graduated_out, :string
  end
end
