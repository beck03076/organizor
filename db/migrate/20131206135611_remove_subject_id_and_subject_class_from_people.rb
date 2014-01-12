class RemoveSubjectIdAndSubjectClassFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :subject_id
    remove_column :people, :subject_class
  end

  def down
    add_column :people, :subject_class, :string
    add_column :people, :subject_id, :integer
  end
end
