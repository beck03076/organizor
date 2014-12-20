class AddExamAndScoreAndGraduatedOutToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :exam, :string
    add_column :qualifications, :score, :string
    add_column :qualifications, :gratuaded_out, :date
  end
end
