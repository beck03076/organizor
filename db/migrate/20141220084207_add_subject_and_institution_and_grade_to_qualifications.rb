class AddSubjectAndInstitutionAndGradeToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :subject, :text
    add_column :qualifications, :institution, :text
    add_column :qualifications, :grade, :string
  end
end
