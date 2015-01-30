class RemoveQuaSubjectAndQuaPartnerAndQuaGradeFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :qua_subject
    remove_column :registrations, :qua_partner
    remove_column :registrations, :qua_grade
  end

  def down
    add_column :registrations, :qua_grade, :string
    add_column :registrations, :qua_partner, :string
    add_column :registrations, :qua_subject, :string
  end
end
