class RemoveQuaSubjectAndQuaInstitutionAndQuaGradeFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :qua_subject
    remove_column :registrations, :qua_institution
    remove_column :registrations, :qua_grade
  end

  def down
    add_column :registrations, :qua_grade, :string
    add_column :registrations, :qua_institution, :string
    add_column :registrations, :qua_subject, :string
  end
end
