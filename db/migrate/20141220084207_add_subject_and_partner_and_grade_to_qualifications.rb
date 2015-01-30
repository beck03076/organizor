class AddSubjectAndPartnerAndGradeToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :subject, :text
    add_column :qualifications, :partner, :text
    add_column :qualifications, :grade, :string
  end
end
